Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F841C761AF
	for <linux-block@archiver.kernel.org>; Sun,  2 Apr 2023 02:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjDBCZO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Apr 2023 22:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjDBCZN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Apr 2023 22:25:13 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659F41CB8F
        for <linux-block@vger.kernel.org>; Sat,  1 Apr 2023 19:25:12 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-62810466cccso1439938b3a.1
        for <linux-block@vger.kernel.org>; Sat, 01 Apr 2023 19:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680402312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fNJn7rJ9mfi+8BFFswpknbpijn0YYNUZ+eri+Zl6WMI=;
        b=KeSs8TLuUJ9k46im3nNlZft8qdRNFcPvl/dsXf01zYGR4qNwLMZGaC8JjwmwKhdSWo
         h+bvguldTAPmOdwC3Ox5IAUJa1/FRehs3Wb3sszcFYjIRBkZ6RBXl+EAdpOHH3RhhrnR
         NYV1yBLMPyVV565lYNviJPnzYwBCS1NQgOS7JoqEL9+vm0ZVf7vxXuik3CM0j0SHPlRg
         XR464QAuAMYt8WMySF1bHOMdgTSVZ9X/n1z13nbyqjTZT8XEucF7+sA27OSst+JnlWIy
         IkO5kW/ZomqVw1PVfMuwLnXuvo6rkQJ+1z50Dp0oXGFd6fIC6tDFHJQulFqp9PEA150Y
         51gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680402312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNJn7rJ9mfi+8BFFswpknbpijn0YYNUZ+eri+Zl6WMI=;
        b=ddN1lXYz268a9z0lkiYsLf7e1nEY3g377cTcL6DUyKH3hyMsSVXGAW6vFeluuEmWKE
         pvHR5mvAgqKSI3/SpnrDGXBfseKvpbHxmdCbzzPeCPuMDy8k+QddoPCEA8Qgcyeb44em
         flIsj9p9wR8MrML2e1m4WIJy5N9gOhZhuu3o5GCsk8vOYwMHlnmuJW+yETcSfBegOFrP
         Txc3vP3/Tvyqp/FTiCjdqya2OpCgSpP9Jo0Tz9K2ANhV5M/wPFkRC21NLWXBCndMORa2
         NmLa6xnfjVjgyUwa0Lr53UUfzYqCJGbjc9RcOJZG/FoTpTyELtmtWheJoslhVVSPDyCv
         OXXA==
X-Gm-Message-State: AAQBX9cVDiYszoEhj4nylbxey1+Ps5P9hcVhAelV4l2cIZ1NlFnrPWBK
        XmUhckbVdztQ0U1PiXtWnPVg1PEnzBkaHejfKip76Q==
X-Google-Smtp-Source: AKy350ZnNIOuLbxw5ULmCgiQnJPVCvCEZyhLzu6XGUcIgGsjYDWtlYY54TXYdTiKrMyiMA/evkBk/g==
X-Received: by 2002:a17:903:41cb:b0:1a2:9940:1f75 with SMTP id u11-20020a17090341cb00b001a299401f75mr8712478ple.0.1680402311736;
        Sat, 01 Apr 2023 19:25:11 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ji21-20020a170903325500b0019956488546sm3934150plb.277.2023.04.01.19.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 19:25:11 -0700 (PDT)
Message-ID: <87e110f9-a57d-520b-6fae-f75d16a71108@kernel.dk>
Date:   Sat, 1 Apr 2023 20:25:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] pktcdvd: simplify the class_pktcdvd logic
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20230331164724.319703-1-gregkh@linuxfoundation.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230331164724.319703-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/31/23 10:47 AM, Greg Kroah-Hartman wrote:
> There is no need to dynamically create and destroy the class_pktcdvd
> structure, just make it static and remove the memory allocation logic
> which simplifies and cleans up the logic a lot.
> 
> Cc: linux-block@vger.kernel.org
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, I would like to take this through my driver-core tree as it is
> needed for other struct class cleanup work I have done and am continuing
> to do there.

I'm going to defer to you on this kind of stuff, so if you think it's
fine, then go for it.

-- 
Jens Axboe


