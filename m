Return-Path: <axboe@kernel.dk>
Received: from [192.168.1.154] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u84sm5140099ioi.53.2017.10.10.08.04.39
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Oct 2017 08:04:40 -0700 (PDT)
Subject: Re: [PATCH] blkcg: check pol->cpd_free_fn before free cpd
To: linux-block@vger.kernel.org
References: <20171010145342.GA24247@localhost.didichuxing.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e161a324-40ba-fac8-d0e0-65b63ea8ceaf@kernel.dk>
Date: Tue, 10 Oct 2017 09:04:39 -0600
MIME-Version: 1.0
In-Reply-To: <20171010145342.GA24247@localhost.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/10/2017 08:53 AM, weiping zhang wrote:
> check pol->cpd_free_fn() instead of pol->cpd_alloc_fn() when free cpd.

In practice this shouldn't make a difference, since if you have an
alloc_fn, you better also have a free_fn. I'd argue a better
patch would be ensuring that's the case, since the current situation
would at least oops and show you there's an issue, but with the patch
we'll just leak the memory.

I'll apply it, but would be nice if this was handled a bit more
proactively.

-- 
Jens Axboe
