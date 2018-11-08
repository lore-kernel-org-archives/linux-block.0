Return-Path: <keith.busch@intel.com>
Date: Thu, 8 Nov 2018 08:37:53 -0700
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Clear kernel memory before copying to user
Message-ID: <20181108153752.GD15857@localhost.localdomain>
References: <CACVXFVO8pcZpK0MBud8oebdZWhKB0Gzr14MPbzMtoHBUkN4Rbg@mail.gmail.com>
 <20181107151538.GA11941@localhost.localdomain>
 <CACVXFVNbzK-WjJDrFjvApHE7R9bG3MnbN6M507d43KnUh3Ujpw@mail.gmail.com>
 <20181107154412.GB11941@localhost.localdomain>
 <CACVXFVPUwc9jDirAk2a4w8WhF-EqLXRputTZ+iOp9=1qAsfoeA@mail.gmail.com>
 <20181107160909.GC11941@localhost.localdomain>
 <CACVXFVMcxNdbFnJd46fd05MJ63NT5VE-M+jrjSqxP0E9zaYcag@mail.gmail.com>
 <20181108012251.GB15857@localhost.localdomain>
 <e867f35f-f9ac-0a37-dbb5-700704bb6364@suse.de>
 <CACVXFVNERaP6eFJxHSBq-LY_Kiawh1h16h4-ALdDYujAgqn4sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVNERaP6eFJxHSBq-LY_Kiawh1h16h4-ALdDYujAgqn4sQ@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 08, 2018 at 07:10:58PM +0800, Ming Lei wrote:
> I guess the issue may depend on specific QEMU version, just tried the test over
> virtio-scsi/sata/usb-storage emulated via qemu-2.10.2-1.fc27, not observed
> this problem.

I actually didn't use virtio-scsi, but it really doesn't matter.

FWIW, this is what I ran:

  # qemu-system-x86_64 --version
  QEMU emulator version 2.10.2(qemu-2.10.2-1.fc27)

  # qemu-system-x86_64 -m 192 -smp 2 -enable-kvm -display none -snapshot \
    -hda /mnt/images/fedora-27.img  -nographic \
    -append "console=tty0 console=ttyS0 root=/dav/sda rw" \
    -kernel /boot/vmlinuz-4.18.10-100.fc27.x86_64 \
    -initrd /boot/initramfs-4.18.10-100.fc27.x86_64.img

The file "fedora-27.img" is just a filesystem image of a minimal mock
setup from /var/lib/mock/fedora-27-x86_64/root/.

A small memory size makes it easier to observe, otherwise your probability
of allocating unclean pages lowers. That's really the only reason I used
qemu since all my real machines have too much memory that I never come
close to using, making observations more random.
