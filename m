Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: testing io.low limit for blk-throttle
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Shaohua Li <shli@fb.com>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <A749046B-BEB9-4278-ABEF-3007817D59DD@linaro.org>
 <180654d2-17ef-0d25-bef6-f526e9ec4ea3@oracle.com>
 <0AAB1A24-0E2E-4054-8D7F-6C1D69379A1F@linaro.org>
 <cbd82e3d-4465-864d-c057-898135626362@oracle.com>
 <94F005D5-EC8B-4830-AD5B-489117F7DC60@linaro.org>
 <5921aa86-37d9-a85d-18da-ff363ff83cf2@oracle.com>
 <61EA7529-E6F7-4708-A621-CCAC1FBFFCF8@linaro.org>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <e11cb30e-0699-bc5f-522f-a56d9a00896d@oracle.com>
Date: Mon, 23 Apr 2018 16:26:10 +0800
MIME-Version: 1.0
In-Reply-To: <61EA7529-E6F7-4708-A621-CCAC1FBFFCF8@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Paolo

When I test execute the script, I got this
8:0 rbps=10000000 wbps=0 riops=0 wiops=0 idle=0 latency=max

The idle is 0.
I'm afraid the io.low would not work.
Please refer to the following code in tg_set_limit

	/* force user to configure all settings for low limit  */
	if (!(tg->bps[READ][LIMIT_LOW] || tg->iops[READ][LIMIT_LOW] ||
	      tg->bps[WRITE][LIMIT_LOW] || tg->iops[WRITE][LIMIT_LOW]) ||
	    tg->idletime_threshold_conf == DFL_IDLE_THRESHOLD ||    //-----> HERE
	    tg->latency_target_conf == DFL_LATENCY_TARGET) {
		tg->bps[READ][LIMIT_LOW] = 0;
		tg->bps[WRITE][LIMIT_LOW] = 0;
		tg->iops[READ][LIMIT_LOW] = 0;
		tg->iops[WRITE][LIMIT_LOW] = 0;
		tg->idletime_threshold = DFL_IDLE_THRESHOLD;
		tg->latency_target = DFL_LATENCY_TARGET;
	} else if (index == LIMIT_LOW) {
		tg->idletime_threshold = tg->idletime_threshold_conf;
		tg->latency_target = tg->latency_target_conf;
	}

	blk_throtl_update_limit_valid(tg->td);


Thanks
Jianchao

On 04/23/2018 03:37 PM, Paolo Valente wrote:
> cd thr-lat-with-interference
> sudo ./thr-lat-with-interference.sh -b t -w 100000000 -W "10000000 10000000 10000000 10000000 10000000 10000000" -n 6 -T "read read read read read read" -R "0 0 0 0 0 0"
