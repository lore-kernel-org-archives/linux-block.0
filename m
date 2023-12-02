Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C74B21378;
	Sat,  2 Dec 2023 22:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFD1C433C9;
	Sat,  2 Dec 2023 22:07:45 +0000 (UTC)
Date: Sat, 2 Dec 2023 17:07:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Edward Adam Davis <eadavis@qq.com>,
 syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com,
 akpm@linux-foundation.org, axboe@kernel.dk, dvyukov@google.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 pengfei.xu@intel.com, syzkaller-bugs@googlegroups.com, "yukuai (C)"
 <yukuai3@huawei.com>
Subject: Re: [PATCH next] trace/blktrace: fix task hung in blk_trace_ioctl
Message-ID: <20231202170743.7557e7b5@rorschach.local.home>
In-Reply-To: <5116cbb4-2c85-2459-5499-56c95bb42d16@huaweicloud.com>
References: <00000000000047eb7e060b652d9a@google.com>
	<tencent_6537E04AAC74F976B567603CEB377A96FA09@qq.com>
	<5116cbb4-2c85-2459-5499-56c95bb42d16@huaweicloud.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 2 Dec 2023 17:19:25 +0800
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> Hi,
>=20
> =E5=9C=A8 2023/12/02 17:01, Edward Adam Davis =E5=86=99=E9=81=93:
> > The reproducer involves running test programs on multiple processors se=
parately,
> > in order to enter blkdev_ioctl() and ultimately reach blk_trace_ioctl()=
 through
> > two different paths, triggering an AA deadlock.
> >=20
> > 	CPU0						CPU1
> > 	---						---
> > 	mutex_lock(&q->debugfs_mutex)			mutex_lock(&q->debugfs_mutex)
> > 	mutex_lock(&q->debugfs_mutex)			mutex_lock(&q->debugfs_mutex)
> >=20
> >=20
> > The first path:
> > blkdev_ioctl()->
> > 	blk_trace_ioctl()->
> > 		mutex_lock(&q->debugfs_mutex)
> >=20
> > The second path:
> > blkdev_ioctl()->			=09
> > 	blkdev_common_ioctl()->
> > 		blk_trace_ioctl()->
> > 			mutex_lock(&q->debugfs_mutex) =20
> I still don't understand how this AA deadlock is triggered, does the
> 'debugfs_mutex' already held before calling blk_trace_ioctl()?

Right, I don't see where the mutex is taken twice. You don't need two
paths for an AA lock, you only need one.

>=20
> >=20
> > The solution I have proposed is to exit blk_trace_ioctl() to avoid AA l=
ocks if
> > a task has already obtained debugfs_mutex.
> >=20
> > Fixes: 0d345996e4cb ("x86/kernel: increase kcov coverage under arch/x86=
/kernel folder")

How does it fix the above? I don't see how the above is even related to thi=
s.

-- Steve

> > Reported-and-tested-by: syzbot+ed812ed461471ab17a0c@syzkaller.appspotma=
il.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >   kernel/trace/blktrace.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
