Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 27 Apr 2018 05:34:31 -0700
From: Tejun Heo <tj@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Benlong Zhang <zhangbenlong@didichuxing.com>, axboe@kernel.dk,
	shli@kernel.org, david@fromorbit.com, linux-block@vger.kernel.org,
	Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH] A tentative patch to bypass REQ_META in blk throttle
Message-ID: <20180427123431.GA2368884@devbig577.frc2.facebook.com>
References: <20180420100554.GA23471@localhost>
 <20180426190118.GP1911913@devbig577.frc2.facebook.com>
 <20180427122006.GA9380@bfoster.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180427122006.GA9380@bfoster.bfoster>
List-ID: <linux-block@vger.kernel.org>

Hello, Brian.

On Fri, Apr 27, 2018 at 08:20:06AM -0400, Brian Foster wrote:
> I thought Josef's work had more to do with tracking/managing dirty
> metadata (i.e., driving writeback/reclaim and whatnot). Perhaps I just
> haven't followed it close enough... how does that relate to cgroup bio
> ownership?

Oh, we've been working on it for a while now but haven't posted the
patches yet.  We should be able to post the patches in several weeks.

Thanks.

-- 
tejun
