Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7208AC00528
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 19:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjGUTo5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 15:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjGUTo5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 15:44:57 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9502B2D7C
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 12:44:55 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-346434c7793so2931385ab.0
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 12:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689968695; x=1690573495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4JV3T5b8TbQqqDK/BVYCQtdyggJjpPOgPu1aX+qbIw=;
        b=l8oREEe30c/6jl4ASOx8eoiEi8J0YXceXHp6NBmZLfqGg8WdCRNDKc2Dx+O3CJPOF0
         Prr1TBL/uBSQ9CkIXVZYWdwUnkqeR1ON7SwhqdlLXB9aw0w++T7AD12u/EU201HsvM+D
         5qPx2xhmmq401qwubR7w+F+d/HiWL0cu8ye8MI4f9nYrBKvREakx7irR918bhW8vqKss
         m/OKoj35KJ5c56Cv9WteGxrb/y/FHSN7ovwCYDItsKIvK+0hbJ8j4fkDosWyjnV+aBHH
         EtbZ3icsiFYvH8NGr4CYi3T3llEK8H8KcJcSBAao/YV0ZigbIUWqoNKIlVkrzbZA+z5P
         QmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689968695; x=1690573495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4JV3T5b8TbQqqDK/BVYCQtdyggJjpPOgPu1aX+qbIw=;
        b=URoeUMwRmELoSU1gCAAayJLOoHlcmGEgArtZk4Rt6HEQL7hm60DiCyeH04cDJ4EmLm
         lChC6tKVmlwWWa8YjKtOupLoS/kDn2LqwGqSyVvHthE6BVof2g7w8/8ie3MwDuEws/1C
         DctegNAmwtrH0RJSGbRdxp6gMhcd5ZJ3WPHoxfjnd9Y8JoftQWQ0RwP62o2pBd5ZDVzM
         fpKtFU07KbyzWc+Pz9FzM+CER3DZLa2//IRJWRaPJbCPp4CTfP6S/2brzU66ITrIBPQo
         fyQMZJlNlRxDyoNV6fUtY1Hyu6qAmbXD0UdQgl/TvnpNdL6C0/a/nJds3xEtJI1Dgx31
         xs3g==
X-Gm-Message-State: ABy/qLb94BLcI+i1OtMAi6QLki/QMR8LJYaW867UqVq+yJiDpsEgOfuu
        9QZhsAXKx4heiIHwp13B3JZChQ==
X-Google-Smtp-Source: APBJJlHh57kNFvHniHLhEStgOH9NnIcwIeYoCvzcO/4sTXVbqJP7vucQP0hit+9dxghi2VgAK4Zhug==
X-Received: by 2002:a92:d44c:0:b0:345:ad39:ff3 with SMTP id r12-20020a92d44c000000b00345ad390ff3mr2677303ilm.3.1689968695018;
        Fri, 21 Jul 2023 12:44:55 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b5-20020a92ce05000000b003460b8505easm1181877ilo.19.2023.07.21.12.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 12:44:54 -0700 (PDT)
Message-ID: <42f33274-6877-1e39-1caf-d8ff0a9bc357@kernel.dk>
Date:   Fri, 21 Jul 2023 13:44:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] dasd fixes
Content-Language: en-US
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20230721193647.3889634-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230721193647.3889634-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/21/23 1:36 PM, Stefan Haberland wrote:
> Hello Jens,
> 
> please apply the following patches that fix some errors in the DASD device
> driver. Thanks.

6.6 fine, or were you targeting 6.5?

-- 
Jens Axboe


