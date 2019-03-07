Return-Path: <SRS0=/o95=RK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3061C43381
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 01:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCEA20675
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 01:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfCGB4k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:56:40 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44938 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfCGB4k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 20:56:40 -0500
Received: by mail-ot1-f65.google.com with SMTP id g1so12676953otj.11;
        Wed, 06 Mar 2019 17:56:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fCw2NB2YqKRPfltyWvyGeT/nMBi+rQEIanpOJVenhNw=;
        b=aZSSzTCXJKMRrTnBdlaNwpJYecbfLY/Bm78eiAKD8YfhiyuQcP9mciWi2Bg61iip/G
         TLmm3diHUdn671AWJuzvpPtga2c7JI+yMASMaQi7Sic+whyBuLy2H18PKM1GbfKuIQpC
         PgPoROlw0JmkoORxge0jRZmFfF5XBmd41QoLHwoDp/ncU1E8wPRgbgc2FA8Kkg2V3UxH
         HouHgv8iWwL+ogXveLJDTS2cKtqOeCZ0+3hH8jcM4NxTYL6WUynXU1NagExJSrUSp0Qi
         4N6PsY13DWgwAu6k1dUPz9tqG8d3LMhysG9RZhwxgleTltLAdUzhtqFE4IXG9t2ruJx6
         ewdA==
X-Gm-Message-State: APjAAAUtgFiemZSk2W62H5z2Hy5sJuj0I767lsVCrTaFET0fXMXJTrJl
        53mRrbc16De4YbZbt9aU2FQ=
X-Google-Smtp-Source: APXvYqzcT/z1AOFeRrGYLx1m5TTN+NchNvQYlcULmXrKN2/fjJ7T+DBI7zBixb05VPasSkfl9cbxjw==
X-Received: by 2002:a9d:74c1:: with SMTP id a1mr6739552otl.107.1551923799101;
        Wed, 06 Mar 2019 17:56:39 -0800 (PST)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id q67sm1329652oif.40.2019.03.06.17.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 17:56:38 -0800 (PST)
Subject: Re: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
To:     Bart Van Assche <bvanassche@acm.org>,
        Tal Gilboa <talgi@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     Yamin Friedman <yaminf@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Idan Burstein <idanb@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
 <1551888921.9796.2.camel@acm.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <392082ba-9aeb-6c5e-53a0-7bb53ce101fa@grimberg.me>
Date:   Wed, 6 Mar 2019 17:56:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551888921.9796.2.camel@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> net_dim.h lib exposes an implementation of the DIM algorithm for dynamically-tuned interrupt
>> moderation for networking interfaces.
>>
>> We need the same behavior for any block CQ. The main motivation is two benefit from maximized
>> completion rate and reduced interrupt overhead that DIM may provide.
> 
> What is a "block CQ"?

There is no such thing... Also, this has no difference
if a block/file/whatever is using the rdma cq.

The naming should really be something like rdma_dim as it accounts
for completions and not bytes/packets.

> How does net_dim compare to lib/irq_poll?

Its orthogonal, its basically adaptive interrupt moderation for
RDMA devices. Its sort of below the irq_poll code. It basically
configures interrupt moderation based on stats collected by
the rdma driver.

> Which approach results in the best performance and lowest latency?

I guess it depends on what is the test case. This approach tries to
apply some time or completion count limit to when the HW should fire
an interrupt based on the load in an adaptive fashion.

The scheme is to try and detect what are the load characteristics and
come up with a moderation parameters that fit. For high interrupt rate
(usually seen with small size high queue-depth workloads) it configures
the device to aggregate some more before firing an interrupt - so less
interrupts, better efficiency per interrupt (finds more completions).
For low interrupt rate (low queue depth) the load is probably low to
moderate and aggregating before firing an interrupt is just added
latency for no benefit. So the algorithm tries to transition between a
number of pre-defined levels according to the load it samples.

This has been widely used by the network drivers for the past decade.

Now, this algorithm while trying to adjust itself by learning the load,
also adds entropy to the overall system performance and latency.
So this is not a trivial trade-off for any workload.

I took a stab at this once (came up with something very similar),
and while for large queue-depth workloads I got up to 2x IOPs as the
algorithm chose aggressive moderation parameters which improved the
efficiency a lot, but when the workload varied the algorithm wasn't very
successful detecting the load and the step direction (I used a variation
of the same basic algorithm from mlx5 driver that net_dim is based on).

Also, QD=1 resulted in higher latency as the algorithm was dangling
between the two lowest levels. So I guess this needs to undergo a
thorough performance evaluation for steady and varying workloads before
we can consider this.

Overall, I think its a great idea to add that to the rdma subsystem
but we cannot make it the default and especially without being able
to turn it off. So this needs to be opt in with a sysctl option.

Moreover, not every device support cq moderation so you need to check
the device capabilities before you apply any of this.
