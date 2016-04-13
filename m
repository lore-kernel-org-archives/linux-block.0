Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55412 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933665AbcDMHDK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 13 Apr 2016 03:03:10 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: dm-devel@redhat.com
Cc: Mike Snitzer <snitzer@redhat.com>, linux-scsi@vger.kernel.org,
	sagig@dev.mellanox.co.il, jmoyer@redhat.com,
	linux-block@vger.kernel.org, j-nomura@ce.jp.nec.com
Subject: Re: [dm-devel] [RFC PATCH 0/4] dm mpath: vastly improve blk-mq IO performance
Date: Wed, 13 Apr 2016 09:03:06 +0200
Message-ID: <1894861.yMOs7f7bAi@c203>
In-Reply-To: <20160408192938.GC8453@redhat.com>
References: <1459454666-76428-1-git-send-email-snitzer@redhat.com> <2760420.6GyDefUaH5@c203> <20160408192938.GC8453@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Freitag, 8. April 2016 15:29:39 CEST Mike Snitzer wrote:
> On Fri, Apr 08 2016 at  7:42am -0400,
> Johannes Thumshirn <jthumshirn@suse.de> wrote:
> 
> > Ladies and Gentlemen,
> > To show off some numbers from our testing:
> > 
> > All tests are performed against the cache of the Array, not the disks as we 
> > wanted to test the Linux stack not the Disk Array.
> > 
> > All single queue tests have been performed with the deadline I/O Scheduler.
> > 
> > Comments welcome, have fun reading :-)
> 
> Any chance you collected performance results from DM MQ on this same
> testbed without any variant of my lockless patches?  The DM SQ results
> aren't too interesting a reference point.  Seeing how much better
> lockless DM MQ (multipath) is than the old m->lock heacy code (still in
> 4.6) would be more interesting.
> 
> Not a big deal if you don't have it.. but figured I'd check to see.

I'll have to look if there are some of the old logfiles still available, but we
can't re-test, as the array was just temporarily allocated to us and we've
now lost access to it. But IIRC it's been somewhere around 300K IOPS, but 
don't quote me on that.

Byte,
	Joahnnes

 
> And thanks for the numbers you've provided.
> Mike
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel
> 


-- 
Johannes Thumshirn                                                                                Storage
jthumshirn@suse.de                                                             +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

