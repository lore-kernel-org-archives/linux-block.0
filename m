Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40222C2D0F2
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 15:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E2220786
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 15:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obQKA52V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbgCaPY6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:24:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42990 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbgCaPY5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 11:24:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id 22so10465262pfa.9
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6FahT8x90WNHEEj3oMiZ/ShKhSZD8ajLBlpxau/7+rU=;
        b=obQKA52V+aibNLR7ijxuIcGBoA6P2Jr4R6YdarkbEj60cnP08xZnf8tFcb7prYuVQK
         vSaZgdHxMbxpWCCB8X+9gljqaKIWv8mK3rC37kxEi3hMS+fol5ysxO3s86DYH6G6Z6Ia
         dwWLEOiwLuCNkpxJd3cbRHnlRrZno9LBSqVSUo8q8lO8IG6lkI0Zc07nP0E4AraUE7l0
         pzsssu9ZuqhsFBdv0Qpeivm7yO0cSI1YM49nD6aHDrCyEzbVfEkv9bNX9FkiR4vB5oQM
         FrdBCGVQQm2pqZJSo6UulPImEcGvX52rbTFLkU8aDmkQ9Rse5ocb3lMrAOa3UNnPIONY
         Bzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6FahT8x90WNHEEj3oMiZ/ShKhSZD8ajLBlpxau/7+rU=;
        b=KkDLZer0KULF2xWHfGdY1D3/0FEuOnxFAF+MDOnW8B/MfCk8HmBVTy/OB6NTvM3vQK
         6VOb2Z9V3yHok0Yh/UR5AGy/0YXowe97n7K8DSJyh5BLadixFALzVxiQ/2v9uQlLujA1
         FaVnyvGhlPwuZIasanELA4uAxZeQb1FujPk58SbX0FlzcB0K2qwpM0llsPMKaiWRZdsu
         NSEGHvDH62gMOyVoN3uWF1b8J4EqVAaJDiaRkYEQryeLyab+zh/NXZ5RRcRmNpNPEjfL
         oah2etEErwu55uoWm2EtoJQ5rqURZXWkxTu8q73Era4ektQaw0t6BrZc8rjEYMzekRfh
         VdJw==
X-Gm-Message-State: AGi0PuZolGe6COs0Let6fHUk8wALmnIbY9STpfjIcwxUvoB94qG33oYa
        5h4W5Rb0p6C28rm8UfT6HTkrK6ix
X-Google-Smtp-Source: APiQypKejXVVSk70bM7Kz1AwJxT32HiTMDJNu9AaEukwpa+Inc8Lv9B5MNiRM6mgILrcauM5QKaRpA==
X-Received: by 2002:aa7:8a99:: with SMTP id a25mr5110325pfc.76.1585668294930;
        Tue, 31 Mar 2020 08:24:54 -0700 (PDT)
Received: from ?IPv6:240b:10:2720:5510:a182:288:3ffa:432a? ([240b:10:2720:5510:a182:288:3ffa:432a])
        by smtp.gmail.com with ESMTPSA id y4sm583215pfo.39.2020.03.31.08.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 08:24:54 -0700 (PDT)
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting
 value
To:     Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
 <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
 <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
 <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com>
 <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
 <a0e7a985-a726-8e16-d29c-eb38a919e18e@gmail.com>
 <CACVXFVMsPstD2ZLnozC8-RsaJ7EMZK9+d47Q+1Z0coFOw3vMhg@mail.gmail.com>
 <cc1534d1-34f6-ffdb-27bd-73590ab30437@gmail.com>
 <20200330135323.GA32604@C02WT3WMHTD6>
From:   Tokunori Ikegami <ikegami.t@gmail.com>
Message-ID: <6c35a4f9-af19-feff-6be0-d9c023d6c6b7@gmail.com>
Date:   Wed, 1 Apr 2020 00:24:50 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330135323.GA32604@C02WT3WMHTD6>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2020/03/30 22:53, Keith Busch wrote:
> On Mon, Mar 30, 2020 at 06:15:41PM +0900, Tokunori Ikegami wrote:
>> But there is a case that the command data length is limited by 512KB.
>> I am not sure about this condition so needed more investigation.
> Your memory is too fragmented. You need more physically contiguous
> memory or you'll hit the segment limit before you hit the length
> limit. Try allocating huge pages.

Thank you so much for your advise.
I have confirmed that the 512KB case is limited by the 127 segments 
check below in ll_new_hw_segment().

     if (req->nr_phys_segments + nr_phys_segs > 
queue_max_segments(req->q)) {

Also confirmed that the 4MB limit works correctly with the memory 
condition not fragmented too much.
I will do abandon the patch to increase max segments as limited 4MB now 
by NVMe PCIe driver.

Regards,
Ikegami

