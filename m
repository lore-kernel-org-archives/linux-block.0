Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] cfq-iosched: fix the delay of cfq_group's vdisktime
 under iops mode
To: Hou Tao <houtao1@huawei.com>
Cc: linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <1488975415-40417-1-git-send-email-houtao1@huawei.com>
 <20170308140518.GE19740@quack2.suse.cz>
 <dc6db873-1958-7812-bfea-5d9396c53818@huawei.com>
 <23092e51-2ee6-fc0d-988b-6c540e4f8661@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8afa289d-4448-56bb-ae96-e1ddd40d2078@kernel.dk>
Date: Wed, 31 May 2017 09:25:47 -0600
MIME-Version: 1.0
In-Reply-To: <23092e51-2ee6-fc0d-988b-6c540e4f8661@huawei.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/30/2017 09:09 PM, Hou Tao wrote:
> Hi Jens,
> 
> I didn't found the patch in your linux-block git tree and the vanilla git tree.
> Maybe you have forgot this CFQ fix ?

Looks like that did get missed, sorry about that. I've queued it up now.

-- 
Jens Axboe
