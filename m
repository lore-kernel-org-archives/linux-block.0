Return-Path: <axboe@kernel.dk>
Received: from [10.211.99.86] ([94.127.55.205])
        by smtp.gmail.com with ESMTPSA id 58sm5303659edt.75.2017.09.30.01.22.12
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Sep 2017 01:22:12 -0700 (PDT)
Subject: Re: [PATCH v2] null_blk: add "no_sched" module parameter
To: linux-block@vger.kernel.org
References: <20170930014917.GA10442@localhost.didichuxing.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7438a8b4-83b4-436c-2267-a407fc93dac4@kernel.dk>
Date: Sat, 30 Sep 2017 10:22:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170930014917.GA10442@localhost.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/30/2017 03:49 AM, weiping zhang wrote:
> add an option that disable io scheduler for null block device.

Applied for 4.15, thanks.

-- 
Jens Axboe
