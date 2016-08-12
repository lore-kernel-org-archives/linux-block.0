Return-Path: <linux-block-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:41956 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbcHLJRW (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 12 Aug 2016 05:17:22 -0400
Date: Fri, 12 Aug 2016 10:16:45 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tom Yan <tom.ty89@gmail.com>, Tejun Heo <tj@kernel.org>,
	jmoyer@redhat.com, axboe@fb.com, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 2/2] libata-core: do not set dev->max_sectors for
 LBA48 devices
Message-ID: <20160812101645.0a4a5e9f@lxorguk.ukuu.org.uk>
In-Reply-To: <yq1mvkipwx5.fsf@sermon.lab.mkp.net>
References: <5eceeb9ad825beb87db03b0989f746dfbe0cf3fe.1470753817.git.tom.ty89@gmail.com>
	<10c4d38005e24bb477b5182d4fc17879139f14d9.1470753817.git.tom.ty89@gmail.com>
	<20160810041042.GH25053@mtj.duckdns.org>
	<CAGnHSE=z78AjDC13XKk_WnkQcjFHWGcatciwoJJYW-97a0qWjQ@mail.gmail.com>
	<yq1twesq8lm.fsf@sermon.lab.mkp.net>
	<CAGnHSEn3pXR33Ju+mr0DYdE0G7kNhxNCbvocX1pZXvYfxx5+3A@mail.gmail.com>
	<yq1mvkipwx5.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> Tom> is totally irrational for a general default. I mean, given that it
> Tom> was 1024 (512k), try to double it? Fine. Try to quadruple it?
> Tom> Alright.  We'll need to deal with some alignment / boundary issue
> Tom> (like the typical 65535 vs 65536 case)? Okay let's do it. But
> Tom> what's the sense in picking a random RAID configuartion as the base
> Tom> to decide the default?  
> 
> I agree that the new default is completely arbitrary. And I think there
> was a bit of controversy at the time. However, the numbers were
> compelling so the change went in.

For older SCSI and especially ATA drives (and it wouldn't surprise me if
it is true of modern ones) there are also huge latency tradeoffs. Before
you jump up and down about numbers what are the latency numbers like on
classic ATA drives with that sized block I/O. You could easily up your
RAID numbers while wrecking realtime and desktop performance.

Without NCQ you certainly don't want huge I/O's blocking up the
controller, with NCQ it depends if the firmware these days has improved
and understands any kind of fairness or like the early ones and older
SCSI drives will happily starve requests.

Conceptually it also seems wrong - if you want to avoid partial stripe
writes on a consumer grade disk subsystem then use smaller stripes.

At the ATA level we can detect both the presence of command queueing
ability, and also whether the device is spinnning rust or not, so it may
be smarter defaults could be done based upon whether the device is an SSD
or not.

Alan
