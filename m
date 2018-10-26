Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1540567279.66186.99.camel@acm.org>
Subject: Re: [PATCH] floppy: Avoid memory access beyond the array bounds in
 setup_rw_floppy()
From: Bart Van Assche <bvanassche@acm.org>
To: Kyungtae Kim <kt0755@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>, DaeRyong
 Jeong <threeearcat@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 26 Oct 2018 08:21:19 -0700
In-Reply-To: <CAEAjamtxZRiFUYb4re3jRf9naoSyJO7sskChfEgcBh-m-uEKWQ@mail.gmail.com>
References: 
	<CAEAjamtxZRiFUYb4re3jRf9naoSyJO7sskChfEgcBh-m-uEKWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-10-26 at 10:39 -0400, Kyungtae Kim wrote:
+AD4 setup+AF8-rw+AF8-floppy() writes some bytes of array cmd to the floppy disk
+AD4 controller, depending on cmd+AF8-count.
+AD4 Although the size of array cmd is fixed like 16, cmd+AF8-count can be much
+AD4 larger through raw+AF8-cmd+AF8-ioctl().
+AD4 Noticed there is no bound check for this, thereby leading to invalid
+AD4 memory access.

Against which kernel tree did you prepare this patch? Just above the code
you want to insert I found the following:

	if (ptr-+AD4-cmd+AF8-count +AD4 33) ...

Why does that statement compare cmd+AF8-count with 33? Is that comparison correct
or not? Anyway, I don't think it makes sense first to compare cmd+AF8-count against
33 and next to compare it against 16 ...

+AD4 +-       if (ptr-+AD4-cmd+AF8-count +AD4 ARRAY+AF8-SIZE(ptr-+AD4-cmd))
+AD4 +-               return -EINVAL+ADs

This comparison looks suspicious to me. Almost every comparison of the type
+ACI... +AD4 ARRAY+AF8-SIZE()+ACI I have seen so far was wrong and should be changed into
+ACI... +AD4APQ ARRAY+AF8-SIZE()+ACI instead.

Bart.
