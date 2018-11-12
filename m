Return-Path: <Golden_Miller83@protonmail.ch>
Date: Mon, 12 Nov 2018 13:52:52 +0000
To: Omar Sandoval <osandov@osandov.com>
From: Jordan Glover <Golden_Miller83@protonmail.ch>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, "kernel-team@fb.com" <kernel-team@fb.com>, Bart Van Assche <bvanassche@acm.org>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH v2] kyber: fix wrong strlcpy() size in trace_kyber_latency()
Message-ID: <R0mJspAeiK4p3pJgk66QZssor1zmxudXBmaX7-rPmDAK5dvMu_lEujQl80ajf6g8MTr5ZabOQN7MwHSXW4QBWdG8TfT7ocmqGXI3i4nsQp4=@protonmail.ch>
In-Reply-To: <7cd2a3c7ceed5dea16bc4ccf8edad77e90a49e7a.1542010053.git.osandov@fb.com>
References: <7cd2a3c7ceed5dea16bc4ccf8edad77e90a49e7a.1542010053.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Monday, November 12, 2018 9:08 AM, Omar Sandoval <osandov@osandov.com> w=
rote:

> From: Omar Sandoval osandov@fb.com
>
> When copying to the latency type, we should be passing LATENCY_TYPE_LEN,
> not DOMAIN_LEN (this isn't a problem in practice because we only pass
> "total" or "I/O"). Fix it by changing all of the strlcpy() calls to use
> sizeof().
>
> Fixes: 6c3b7af1c975 ("kyber: add tracepoints")
> Reported-by: Jordan Glover Golden_Miller83@protonmail.ch
> Signed-off-by: Omar Sandoval osandov@fb.com
>
> Changes from v1:
>
> -   Change to using sizeof() instead of constants
>
>     include/trace/events/kyber.h | 8 ++++----
>     1 file changed, 4 insertions(+), 4 deletions(-)
>
>     diff --git a/include/trace/events/kyber.h b/include/trace/events/kybe=
r.h
>     index a9834c37ac40..c0e7d24ca256 100644
>     --- a/include/trace/events/kyber.h
>     +++ b/include/trace/events/kyber.h
>     @@ -31,8 +31,8 @@ TRACE_EVENT(kyber_latency,
>
>     TP_fast_assign(
>     __entry->dev =3D disk_devt(dev_to_disk(kobj_to_dev(q->kobj.parent)));
>
> -         strlcpy(__entry->domain, domain, DOMAIN_LEN);
>
>
> -         strlcpy(__entry->type, type, DOMAIN_LEN);
>
>
>
> -         strlcpy(__entry->domain, domain, sizeof(__entry->domain));
>
>
> -         strlcpy(__entry->type, type, sizeof(__entry->type));
>
>           __entry->percentile=09=3D percentile;
>
>           __entry->numerator=09=3D numerator;
>
>           __entry->denominator=09=3D denominator;
>
>
>
> @@ -60,7 +60,7 @@ TRACE_EVENT(kyber_adjust,
>
> TP_fast_assign(
> __entry->dev =3D disk_devt(dev_to_disk(kobj_to_dev(q->kobj.parent)));
>
> -         strlcpy(__entry->domain, domain, DOMAIN_LEN);
>
>
>
> -         strlcpy(__entry->domain, domain, sizeof(__entry->domain));
>
>           __entry->depth=09=09=3D depth;
>
>
>     ),
>
>     @@ -82,7 +82,7 @@ TRACE_EVENT(kyber_throttled,
>
>     TP_fast_assign(
>     __entry->dev =3D disk_devt(dev_to_disk(kobj_to_dev(q->kobj.parent)));
>
>
> -         strlcpy(__entry->domain, domain, DOMAIN_LEN);
>
>
>
> -         strlcpy(__entry->domain, domain, sizeof(__entry->domain));
>
>
>     ),
>
>     TP_printk("%d,%d %s", MAJOR(__entry->dev), MINOR(__entry->dev),
>
>
> --
> 2.19.1

Tested-by: Jordan Glover <Golden_Miller83@protonmail.ch>
