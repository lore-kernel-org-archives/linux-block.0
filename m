Return-Path: <zhangweiping@didichuxing.com>
Date: Fri, 15 Sep 2017 22:01:54 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Add wrapper for blkcg policy operatins
Message-ID: <20170915140154.GA11335@bogon.didichuxing.com>
References: <cover.1504275001.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1504275001.git.zhangweiping@didichuxing.com>
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 01, 2017 at 10:16:45PM +0800, weiping zhang wrote:
> The first patch is the V2 of [PATCH] blkcg: check pol->cpd_free_fn
> before free cpd, it fixs a checking before free cpd.
> 
> The second patch add some wrappers for struct blkcg_policy->xxx_fn, because not
> every block cgroup policy implement all operations.
> 
> weiping zhang (2):
>   blkcg: check pol->cpd_free_fn before free cpd
>   blkcg: add wrappers for struct blkcg_policy operations
> 
>  block/blk-cgroup.c         | 57 +++++++++++++++++-------------------
>  include/linux/blk-cgroup.h | 72 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+), 30 deletions(-)
> 
Hello Jens,

ping
