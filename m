Return-Path: <linux-block-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:51408 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755802AbdLOVP2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Dec 2017 16:15:28 -0500
Date: Fri, 15 Dec 2017 16:15:01 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Byungchul Park <max.byungchul.park@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, david@fromorbit.com,
        willy@infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, byungchul.park@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        oleg@redhat.com
Subject: Re: [PATCH] locking/lockdep: Remove the cross-release locking checks
Message-ID: <20171215211501.v6x6o2ft4khqgbgy@thunk.org>
References: <CANrsvRPQcWz-p_3TYfNf+Waek3bcNNPniXhFzyyS=7qbCqzGyg@mail.gmail.com>
 <20171213104617.7lffucjhaa6xb7lp@gmail.com>
 <CANrsvRPuhPyh1nFnzdYj8ph7e1FQRw_W_WN2a1tm9fzpAYks4g@mail.gmail.com>
 <CANrsvRP3-bWatoaq1teNFG1RXRbazqnHvOKXe458eAxSdAnsfg@mail.gmail.com>
 <20171215062428.5dyv7wjbzn2ggxvz@thunk.org>
 <CANrsvROwvaZzAmTGFH=BaPohkXEB=HhDRdM3xdmPu0m4mjDpfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANrsvROwvaZzAmTGFH=BaPohkXEB=HhDRdM3xdmPu0m4mjDpfw@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Dec 15, 2017 at 05:39:25PM +0900, Byungchul Park wrote:
> 
> All locks should belong to one class if each path of acquisition
> can be switchable each other within the class at any time.
> Otherwise, they should belong to a different class.

OK, so let's go back to my case of a Network Block Device with a local
file system mounted on it, which is then exported via NFS.

So an incoming TCP packet can go into the NFS server subsystem, then
be processed by local disk file system, which then does an I/O
operation to the NBD device, which results in an TCP packet being sent
out.  Then the response will come back over TCP, into the NBD block
layer, then into the local disk file system, and that will result in
an outgoing response to the TCP connection for the NFS protocol.

In order to avoid cross release problems, all locks associated with
the incoming TCP connection will need to be classified as belonging to
a different class as the outgoing TCP connection.  Correct?  One
solution might be to put every single TCP connection into a separate
class --- but that will explode the number of lock classes which
Lockdep will need to track, and there is a limited number of lock
classes (set at compile time) that Lockdep can track.  So if that
doesn't work, we will have to put something ugly which manually makes
certain TCP connections "magic" and require them to be put into a
separate class than all other TCP connections, which will get
collapsed into a single class.  Basically, any TCP connection which is
either originated by the kernel, or passed in from userspace into the
kernel and used by some kernel subsystem, will have to be assigned its
own lockdep class.

If the TCP connection gets closed, we don't need to track that lockdep
class any more.  (Or if a device mapper device is torn down, we
similarly don't need any unique lockdep classes created for that
device mapper device.)  Is there a way to tell lockdep that a set of
lockdep classes can be released so we can recover the kernel memory to
be used to track some new TCP connection or some new device mapper
device?

						- Ted
