Return-Path: <loberman@redhat.com>
Return-Path: <loberman@redhat.com>
Message-ID: <1541692483.24444.3.camel@redhat.com>
Subject: Re: [PATCH 2/2] blk-mq: provide a helper to check if a queue is busy
From: Laurence Oberman <loberman@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Mike Snitzer <snitzer@redhat.com>
Date: Thu, 08 Nov 2018 10:54:43 -0500
In-Reply-To: <20181108154216.23853-3-axboe@kernel.dk>
References: <20181108154216.23853-1-axboe@kernel.dk>
	 <20181108154216.23853-3-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-11-08 at 08:42 -0700, Jens Axboe wrote:
> +static bool blk_mq_check_busy(struct blk_mq_hw_ctx *hctx, struct
> request *rq,
> +                             void *priv, bool reserved)
> +{
> +       bool *busy = (bool *) priv;
> +
> +       /*
> +        * If we find a request, we know the queue is busy. Return
> false
> +        * to stop the iteration.
> +        */
> +       *busy = true;
> +       return false;
> +}
> +

Hi Jens,

Trying to understand the logic, likely just my lack of knowledge
You return false after setting true because you say we know the queue
is busy.
How do we know we found a request here
I dont see you check the result of 
 bool *busy = (bool *) priv;
Is the assumption here because this was called we already knew we had a
request

Apologies it its just my lack of understanding

+static bool blk_mq_check_busy(struct blk_mq_hw_ctx *hctx, struct
request *rq,
+                             void *priv, bool reserved)
+{
+       bool *busy = (bool *) priv;
+
+       /*
+        * If we find a request, we know the queue is busy. Return
false
+        * to stop the iteration.
+        */
+       *busy = true;
+       return false;
+}
+
