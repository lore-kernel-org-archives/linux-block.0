Return-Path: <kt0755@gmail.com>
MIME-Version: 1.0
References: <CAEAjamtxZRiFUYb4re3jRf9naoSyJO7sskChfEgcBh-m-uEKWQ@mail.gmail.com>
 <1540567279.66186.99.camel@acm.org>
In-Reply-To: <1540567279.66186.99.camel@acm.org>
From: Kyungtae Kim <kt0755@gmail.com>
Date: Fri, 26 Oct 2018 11:49:10 -0400
Message-ID: <CAEAjamuJjjyWFw9Fn4_6-97WDhpWTfvLNQdPHT-AZ843yese9g@mail.gmail.com>
Subject: Re: [PATCH] floppy: Avoid memory access beyond the array bounds in setup_rw_floppy()
To: bvanassche@acm.org
Cc: Jens Axboe <axboe@kernel.dk>, jikos@kernel.org,
	Byoungyoung Lee <lifeasageek@gmail.com>, DaeRyong Jeong <threeearcat@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Thank you for your reply.

> Against which kernel tree did you prepare this patch? Just above the code
> you want to insert I found the following:
>
>         if (ptr->cmd_count > 33) ...

Yes, I saw that code as well. But I find out there is no more
additional code relevant to it.
So I guess, that is for like reserved ones for the future work (e.g.,  RESTORE).
And such code cannot solve this crash issue because the crash happens
even when cmd_count is less than 33.

> or not? Anyway, I don't think it makes sense first to compare cmd_count against
> 33 and next to compare it against 16 ...

I agree. So far, seems that removing if (ptr->cmd_count > 33) looks better.
Please let me know if you have better ideas.

> This comparison looks suspicious to me. Almost every comparison of the type
> "... > ARRAY_SIZE()" I have seen so far was wrong and should be changed into
> "... >= ARRAY_SIZE()" instead.

Well, let me check this part again.

Thanks,
Kyungtae Kim
