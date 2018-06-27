Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36365 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752039AbeF0HEw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jun 2018 03:04:52 -0400
Date: Wed, 27 Jun 2018 09:04:50 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 00/15] Add SRP initiator driver tests
Message-ID: <20180627070450.u2w5do6gnzwrcppz@linux-x5ow.site>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
 <CACVXFVMUNWPniJH7Zcw=xC0xb=uRPtgEE_Qh=4xfUUQ-EG4NTQ@mail.gmail.com>
 <217335ac-80ab-fce1-8ba5-6dce11f5cef4@wdc.com>
 <20180626013719.GA31259@ming.t460p>
 <430584e255cc8d25a748bd5d76febb3fd23f8df2.camel@wdc.com>
 <20180626072707.555hshtnr3fgnsxk@linux-x5ow.site>
 <ee7ddc2e-888e-952e-db22-7ff20d72265c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <ee7ddc2e-888e-952e-db22-7ff20d72265c@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 26, 2018 at 08:24:51AM -0700, Bart Van Assche wrote:
> As far as I know the requires() function is per test and there is no such
> function at the group level. I prefer to define this test once at the group
> level instead of copy/pasting the same test thirteen times in each test.

No actually there is.
There is a group_requires() in the test/XXX/group file (check for
instance tests/group/nvme which has group_requires() calling
_have_root and a group_device_requires() calling _test_dev_is_nvme).

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
