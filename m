Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697D4EB64D7
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 10:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjFTKFH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjFTKEt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 06:04:49 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642AA173B
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 03:04:41 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f740497304so1183129e87.0
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 03:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687255476; x=1689847476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ichHBITtiXbhvg4wtZ1vUsPoopXyJCtdwz3MwN/NO4M=;
        b=HFC14K38C2iZOKf+IqRB/V++SRcqqRL6flZTV3tZaO93oy5cP9XDz5tQcv6Pagcme+
         a01B2FTr+1H+oLLRrPL95JHpXUwnGIwoVqQ3hqrR6L/HS+hbQ+HOU9QLYldc2leQND5Q
         OXzWYz/4Lqgot9j7DZ18qwxB0vVDqEDnFwoSvBodrg4RTIJskIKZeVtoOO5PUo9Kp6D6
         ZqZmViViKvBqYJJBll5OJFuD51qvRYeTSUxdQ06WtXN2XiRNbA5LbemsnFCu32fu2XvT
         +c/JRpJKJaaJYajkM11a0sQaRs8CDa793StOZvjjsMh4urY9ea+ahXDAbBYtTcRwueA/
         drpQ==
X-Gm-Message-State: AC+VfDynn666JDW6EHEcBPb1qOUWlgMnW99YLMrsJtNauLzUctzWVhhl
        rNnG4POtsoVrJ3OcywTygtI=
X-Google-Smtp-Source: ACHHUZ6qIHcwF7r810eKQ1dzX3u1KNsQUMwETDgWdDq4ezsW97apVNbzQO9bDsxCveQXRoE8Sh9CxA==
X-Received: by 2002:ac2:5101:0:b0:4f7:640c:1847 with SMTP id q1-20020ac25101000000b004f7640c1847mr5089563lfb.6.1687255476104;
        Tue, 20 Jun 2023 03:04:36 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r11-20020a5d498b000000b00307a86a4bcesm1631011wrq.35.2023.06.20.03.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 03:04:35 -0700 (PDT)
Message-ID: <86c10889-4d4a-1892-9779-a5f7b4e93392@grimberg.me>
Date:   Tue, 20 Jun 2023 13:04:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230620013349.906601-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hello,
> 
> The 1st three patch fixes io hang when controller removal interrupts error
> recovery, then queue is left as frozen.
> 
> The 4th patch fixes io hang when controller is left as unquiesce.

Ming, what happened to nvme-tcp/rdma move of freeze/unfreeze to the
connect patches?

I think that these are patches that should go in regradless because
they also fix I/O failover blocked on request queue enter.
