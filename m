Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 0/2] doc, block, bfq: improve
 documentation on how to to properly configure bfq
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, jeremywh7@gmail.com,
 lnicola@dend.ro
References: <20170831180031.3747-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <56db9c20-ecc6-eefb-6e64-302118cad49c@kernel.dk>
Date: Thu, 31 Aug 2017 13:55:45 -0600
MIME-Version: 1.0
In-Reply-To: <20170831180031.3747-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/31/2017 12:00 PM, Paolo Valente wrote:
> Many users have reported the lack of an HOWTO for properly configuring
> bfq as a function of the goal one wants to achieve (max
> responsiveness, max throughput, ...). The second patch in this
> two-patch series addresses this issue by improving the file
> bfq-iosched.txt in such a way that it also provides some guidance on
> this task. The first patch fixes some issues that I have found while
> working on the file.

Applied for 4.14, thanks Paolo.

-- 
Jens Axboe
