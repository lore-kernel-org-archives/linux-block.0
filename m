Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07142C433FE
	for <linux-block@archiver.kernel.org>; Mon, 28 Nov 2022 14:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiK1OcI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiK1OcE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 09:32:04 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031891F61E
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 06:32:03 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id l7so8159600pfl.7
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 06:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aYzQA5+XofzkuI/jHdZUL6p8mJBbUYeRoj7O8Rf5OpI=;
        b=SW4xPqZEK4MUHUqPivuzG4pYf1aILgJDS/FfdSMbxx8hh+aidc5OMRnzM2GlgujG01
         dqDKMsPmdg06eDdTWDlTS+viqebr+pGplFJ6HJFgRPV2TQUVfWUr8EWyDLuHVwN8gS1r
         y6ESoff3yDBcoCMGUBK7GFbjoyqiyOg2dUQ5HHQEJnNPn9JHOzImnLywRUtNgGRrDWOG
         ZJc+qdeH+eQFlwSWVkHM+cwnOQErS33YBUL2LXrCbXA1Mp1gu/+SDel3dFBKzUqCEZnZ
         juV+JAPSToX5YcUNaIFkPVWGSbBqBrn/F6RkecRfCUY/PZrrBHY5FFwuItPyq2ZlSHdF
         WvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYzQA5+XofzkuI/jHdZUL6p8mJBbUYeRoj7O8Rf5OpI=;
        b=tyRJtM0hrpW2FnnWuIajc7Zs5YfJbBD/N9Qhux2L8taR30ZNcY8K+t1/RP6Sd+uJX1
         eKJ3i/EWEJ6TFBvc7kIPt1Xc3Z4tXuux7L2oAy3a+eUFj7EhNik9ROfD7Ktc1Vw9n+KN
         HMa0cCyitVwZDyiLzKggiUGHUwyQmvaJAyxPSD+v1hLSB/XtFzckTCroeiEawtSDg6Ut
         4bqHbtrWmTLxL1x5iB9c+tV3aOH8i+cwbo9wKXNiXr3I0O+1mQ6N08ImKwgPdUuM9VKD
         AzGSbrjk3o4d06aHSLN92C9Lao8A5cHZWPIFhVdJbfQLbaIg0CCa/4BDJSjhghkY410/
         u/fg==
X-Gm-Message-State: ANoB5plY91fkZbeyOjXRbfikIzguua8007jmDM53VmpRue146fdF3Knp
        DHWGIOvMPMaYGOjLksj7y2qT0w==
X-Google-Smtp-Source: AA0mqf6e1tNCWXVdCniu5KAWoFanIymr34Pr667CIm+FDXDRMjvGr0iio1kf0DVBIwCtvuQd0RLTRg==
X-Received: by 2002:a63:b54:0:b0:434:911a:301 with SMTP id a20-20020a630b54000000b00434911a0301mr29021976pgl.50.1669645922460;
        Mon, 28 Nov 2022 06:32:02 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b10-20020a62a10a000000b005742ee3bf71sm8059568pff.20.2022.11.28.06.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 06:32:02 -0800 (PST)
Message-ID: <423e090a-ac77-ad7e-dfb9-dcbd189e5141@kernel.dk>
Date:   Mon, 28 Nov 2022 07:32:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V6 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-2-paolo.valente@linaro.org>
 <14cea0aa-2f0b-117a-4568-c80ca0513eec@opensource.wdc.com>
 <88084DDA-A705-4CFA-887E-021FC5DD89E9@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <88084DDA-A705-4CFA-887E-021FC5DD89E9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/22 9:28?AM, Paolo Valente wrote:

[snip walls of quoted, useless text[

Guys, can you please both start properly quoting emails? Leave the bit
in place you are responding too, cut the rest. It's almost impossible to
find the signal in all of that noise.

This isn't an isolated incident, which is why I'm bringing it up. The
context is there in previous emails should anyone need it. Not cutting
any of the text when replying is just lazy and puts the onus on the
reader on digging through the haystack to find the needle.

-- 
Jens Axboe
