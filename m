Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BA5C49ED7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9184E208C2
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390378AbfIMWR6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:17:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39742 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390255AbfIMWR5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 18:17:57 -0400
Received: by mail-pl1-f196.google.com with SMTP id bd8so13829181plb.6;
        Fri, 13 Sep 2019 15:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QP/lo8Jl1lZ1N9wZSPvKG3zEpigwgV4XzY19NDDTy18=;
        b=VTptg2lLuJpGoSg5vVDN0a6TbCWlVlazrZlkzcG0f4KcT4CvSfz3NCvAa5m668EG0x
         O0HISIE8+RAIZEgl3dNY5IUgnwMQrRgYPTcaPNPz8YIOb9njdl7pwTQs4cSYK9HkPS/D
         Qsq3AVfwSJKRbrUGhiVZ+GLWlYtFBCd6EN0xq0vtazD5AzVNU9yirvfs0NLUcpnT/pUD
         xUxdETpPttmXYb1t2xVUVtcSJGjsHJ4cvV6qzAJlv9ZzAbSv34AjQhul9/7s94MzkNZ+
         0+y64Hi2EopugWexDWN2YzLdOBWfg7SYA9skMaLwQ5TTzN1gtCU1XjYqEZg4CAE17Pqm
         WDIA==
X-Gm-Message-State: APjAAAWTB1sSBP8pH5pwhunA2jIx5LWIFTZ6yQfXT9KatArmVTDXrETs
        ecGoEcIaylg0i+fRXxBNyuHbdszu
X-Google-Smtp-Source: APXvYqwuzLz1KRz3Fzgu0Tyu1z2M/gsG4gXPsqxXQfDBdTMrV8QoHkTCJxzjrGBowZSPaKhyK6gGiw==
X-Received: by 2002:a17:902:7147:: with SMTP id u7mr51485950plm.260.1568413075606;
        Fri, 13 Sep 2019 15:17:55 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id x8sm10539116pgr.30.2019.09.13.15.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 15:17:54 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] null_blk: do not fail the module load with zero
 devices
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, axboe@kernel.dk, kernel@collabora.com,
        krisman@collabora.com
References: <20190913220300.422869-1-andrealmeid@collabora.com>
 <20190913220300.422869-2-andrealmeid@collabora.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7c0f4547-4193-bd3e-85c6-d950a004ac46@acm.org>
Date:   Fri, 13 Sep 2019 15:17:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913220300.422869-2-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/13/19 3:02 PM, André Almeida wrote:
> The module load should fail only if there is something wrong with the
> configuration or if an error prevents it to work properly. The module
> should be able to be loaded with (nr_device == 0), since it will not
> trigger errors or be in malfunction state. Preventing loading with zero
> devices also breaks applications that configures this module using
> configfs API. Remove the nr_device check to fix this.

I just noticed that this patch is necessary to unbreak blktests. The srp 
tests fail as follows with Jens' for-next branch:

modprobe: ERROR: could not insert 'null_blk': Invalid argument

I think that error is triggered by the following statement in 
common/multipath-over-rdma:

     modprobe null_blk nr_devices=0 || return $?

Bart.
