Return-Path: <axboe@kernel.dk>
Received: from [192.168.1.154] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y200sm2250168itc.4.2017.08.24.07.27.25
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2017 07:27:25 -0700 (PDT)
Subject: Re: [PATCH] block: remove blk_free_devt in add_partition
To: linux-block@vger.kernel.org
References: <20170818155439.GA30487@localhost.didichuxing.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a7a6100b-6741-8b4b-44e9-e2068e698419@kernel.dk>
Date: Thu, 24 Aug 2017 08:27:25 -0600
MIME-Version: 1.0
In-Reply-To: <20170818155439.GA30487@localhost.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 09:54 AM, weiping zhang wrote:
> put_device(pdev) will call pdev->type->release finally, and blk_free_devt
> has been called in part_release(), so remove it.

Your analysis looks correct to me, applied for 4.14.

-- 
Jens Axboe
