Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Subject: Re: What's the best way to call sd_shutdown() on all SCSI disks on
 shutdown?
Date: Mon, 30 Jul 2018 20:35:15 +0000
Message-ID: <6ce597717261cc2ad9deb739703b4175090fd552.camel@wdc.com>
References: <20180730191707.GA28569@thunk.org>
In-Reply-To: <20180730191707.GA28569@thunk.org>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-07-30 at 15:17 -0400, Theodore Y. Ts'o wrote:
+AD4- I've been looking at what's the best way to make sure everything gets
+AD4- cleanly flushed out to disk on a powerdown.  Right now in
+AD4- +AF8AXw-orderly+AF8-poweroff(), we call emergency+AF8-sync() which ki=
cks a workqueue
+AD4- to flush all file systems and block devices --- and then we
+AD4- immediately power down the system, before the scheduler even has a
+AD4- chance to schedule the workqueue thread.  Hopefully userspace has the
+AD4- unmounted all file systems, which will has implicitly issued a cache
+AD4- flush command, but if we have a userspace program writing to a block
+AD4- device directly, currently there's nothing to make sure things will
+AD4- get flushed out to the device.
+AD4-=20
+AD4- Beyond that, though, I'm interested in figuring out how to make sure
+AD4- that all SCSI devices will receive (and acknowledge) SHUTDOWN command
+AD4- so that the disks can be spun down and heads retracted to a safe
+AD4- landing zone before we power down the system.
+AD4-=20
+AD4- It appears the best way to do this is to call sd+AF8-shutdown(), sinc=
e we
+AD4- don't seem to have a high-level +ACI-shutdown+ACI- concept recognized=
 in the
+AD4- block layer (the way we currently, have, say support for +ACI-discard=
+ACI-).
+AD4-=20
+AD4- So the question is, what's the best way to architect something like
+AD4- this.  I could implement a hacky interator loop in the SCSI subsystem=
,
+AD4- and call it directly from +AF8AXw-orderly+AF8-poweroff in kernel/rebo=
ot.c.  But
+AD4- I'm pretty sure that would never get accepted upstream, and so it
+AD4- would remain a Google data center hack.
+AD4-=20
+AD4- What do people think would be the best way of implementing something
+AD4- that would be upstream acceptable?

Hi Ted,

Isn't that behavior a bug in +AF8AXw-orderly+AF8-poweroff()? My understandi=
ng is that
+AF8AXw-orderly+AF8-poweroff() calls run+AF8-cmd(poweroff+AF8-cmd). If the =
poweroff command
gets the chance to run then it will execute the reboot() system call to pow=
er
off the system. The reboot() system call then calls kernel+AF8-power+AF8-of=
f(). That
last function then calls device+AF8-shutdown(). device+AF8-shutdown() calls=
 the
.shutdown() method for all known devices. As you know the sd driver
implements that method. More in detail:

architecture code or ACPI code
-+AD4- orderly+AF8-poweroff()
  -+AD4- poweroff+AF8-work+AF8-func()
    -+AD4- +AF8AXw-orderly+AF8-poweroff()
      -+AD4- run+AF8-cmd(poweroff+AF8-cmd)
        -+AD4- call+AF8-usermodehelper(+ACI-/sbin/poweroff+ACI-)

>From the systemd source file src/core/shutdown.c:

    (void) reboot(RB+AF8-POWER+AF8-OFF)+ADs-

>From kernel/reboot.c:

SYSCALL+AF8-DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
		void +AF8AXw-user +ACo-, arg)
+AHs-
	...
	case LINUX+AF8-REBOOT+AF8-CMD+AF8-POWER+AF8-OFF:
		kernel+AF8-power+AF8-off()+ADs-
		do+AF8-exit(0)+ADs-
		break+ADs-
	...
+AH0-

void kernel+AF8-power+AF8-off(void)
+AHs-
	kernel+AF8-shutdown+AF8-prepare(SYSTEM+AF8-POWER+AF8-OFF)+ADs-
	if (pm+AF8-power+AF8-off+AF8-prepare)
		pm+AF8-power+AF8-off+AF8-prepare()+ADs-
	migrate+AF8-to+AF8-reboot+AF8-cpu()+ADs-
	syscore+AF8-shutdown()+ADs-
	pr+AF8-emerg(+ACI-Power down+AFw-n+ACI-)+ADs-
	kmsg+AF8-dump(KMSG+AF8-DUMP+AF8-POWEROFF)+ADs-
	machine+AF8-power+AF8-off()+ADs-
+AH0-

static void kernel+AF8-shutdown+AF8-prepare(enum system+AF8-states state)
+AHs-
	blocking+AF8-notifier+AF8-call+AF8-chain(+ACY-reboot+AF8-notifier+AF8-list=
,
		(state +AD0APQ- SYSTEM+AF8-HALT) ? SYS+AF8-HALT : SYS+AF8-POWER+AF8-OFF, =
NULL)+ADs-
	system+AF8-state +AD0- state+ADs-
	usermodehelper+AF8-disable()+ADs-
	device+AF8-shutdown()+ADs-
+AH0-

>From drivers/base/core.c:

void device+AF8-shutdown(void)
+AHs-
		...
		if (dev-+AD4-class +ACYAJg- dev-+AD4-class-+AD4-shutdown+AF8-pre) +AHs-
			if (initcall+AF8-debug)
				dev+AF8-info(dev, +ACI-shutdown+AF8-pre+AFw-n+ACI-)+ADs-
			dev-+AD4-class-+AD4-shutdown+AF8-pre(dev)+ADs-
		+AH0-
		if (dev-+AD4-bus +ACYAJg- dev-+AD4-bus-+AD4-shutdown) +AHs-
			if (initcall+AF8-debug)
				dev+AF8-info(dev, +ACI-shutdown+AFw-n+ACI-)+ADs-
			dev-+AD4-bus-+AD4-shutdown(dev)+ADs-
		+AH0- else if (dev-+AD4-driver +ACYAJg- dev-+AD4-driver-+AD4-shutdown) +A=
Hs-
			if (initcall+AF8-debug)
				dev+AF8-info(dev, +ACI-shutdown+AFw-n+ACI-)+ADs-
			dev-+AD4-driver-+AD4-shutdown(dev)+ADs-
		+AH0-
		...
+AH0-

Bart.
