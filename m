Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62618C43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 20:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3970D20851
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 20:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfCHUVW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:21:22 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:35874 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCHUVW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Mar 2019 15:21:22 -0500
Received: by mail-ot1-f52.google.com with SMTP id v62so18479038otb.3
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 12:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8faJgNBQUH0TRrNlIaehO4MPwlVQ3Mb0XmU2bRtaHi8=;
        b=JtRXNBl1kbz9ce8ySzbguGCTmF8O8zH70j1DOawN7kAvMvRGld5MfJSj+Illp5dNUY
         9ZN1KObHxfVZ9t+Uu4TJC7r2DXwwtnk8goGDEuuJgwA9IHFDF7Z8WacKHE5xD/dVbAD0
         VloFks45vT72kgT8GP1EpBdAbs0W1G+3hQT23AXRTk/tdOocEcD9UTyZ8FWwrDLQhdaq
         shNvFm7YPN2nK80OiWWB7YgSF5wTsZtR1CSxNk4aLuiV5BlpBRfgB65kUP7V1mp3Uhy2
         o7C//o4UroQc7v89hUz3D4RXtT/o87S2bHKMWdW7Kcl05mR8Ei5P09EoMHPGv2H+zjos
         Pc5Q==
X-Gm-Message-State: APjAAAXvj9AwjKFPu9KCG01LIlnl5jIiXA+voRA2RCLBybIZgtSF1iFH
        LsqyHcSalyluC28MvLiffSE=
X-Google-Smtp-Source: APXvYqyAh/G5B1pKN1+Rf4thKcIlA7E3WE2oPrUpCy3RTzKNsOpJZyd2IobZUTniH6kmyOsAszff2w==
X-Received: by 2002:a05:6830:1357:: with SMTP id r23mr12926376otq.265.1552076481375;
        Fri, 08 Mar 2019 12:21:21 -0800 (PST)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id r184sm3541135oif.31.2019.03.08.12.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 12:21:20 -0800 (PST)
Subject: Re: [PATCH 1/5] blk-mq: Export reading mq request state
To:     Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>
References: <20190308174006.5032-1-keith.busch@intel.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3c085a51-b309-51fd-c740-924db9fed0c6@grimberg.me>
Date:   Fri, 8 Mar 2019 12:21:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308174006.5032-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For some reason I didn't get patches 2/5 and 3/5...
