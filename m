Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0750BC38145
	for <linux-block@archiver.kernel.org>; Thu,  8 Sep 2022 16:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiIHQUz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Sep 2022 12:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiIHQUy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Sep 2022 12:20:54 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89770E7FAD
        for <linux-block@vger.kernel.org>; Thu,  8 Sep 2022 09:20:52 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z191so389407iof.10
        for <linux-block@vger.kernel.org>; Thu, 08 Sep 2022 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=7dIs3wIU/eOuY42tjUqQIb5hvTxPnOyZmdhm58qw250=;
        b=g+GRDZEFcMsYo9rekqdIoa5Hg2iXa3uKfZ46Kt+XF33CAkT5r2PuNlezw6p7CqOkRJ
         ZTzhch5ZNm2rCTZ//ncC0HGQjZH+z4M9RE3ouRfslW3H/boUfvJjXWL2bok/ySkIqn+y
         lkKrbLWSUCuXZtKTy0jWIKcU28JZRDDtWckN1msYo3e/WWZ4W3b2RdHYB14Z4aGMaMbR
         sqr09sIBnlUQRR1wWiPp1FwvqVY4zFWiHaUgyMQbubzILOJqviZw3xDrqFhsOwjkOauv
         wBR+1Yw3bSzkUEMwA6p/HuwYNEMzHU2qvnoWs9oKVOvX5Xy5i28WQkBOHo3VKtRFU1Dx
         mCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7dIs3wIU/eOuY42tjUqQIb5hvTxPnOyZmdhm58qw250=;
        b=HjuN3CgDdBYWDsh5zDHhLY16pEEnI52iK3vN0RDnk+FR2tG5WNhCVzsbuB0zIJEFel
         Tu6GWOgXytumlzDKVGkQDCoN2zfVI1BRV+5oOmtsm88mZ+Nd4SMoDFY/ZQ3OHPbOLe4D
         B9xLN44PMjAJ9DYoKW+o7ShC4Zbc9MF4mXQgHhYGx90IwaaJ/8ZnFGOkxdDUS510P7E4
         Bz0A4Sp3wBpjfy77r4tB8eahWY9oLyeEjtqB/W9zkUl+OHOgOahW0IIOgOAuRrHgLgTX
         A8Jl04SPn7ckKAh9RJ3HfpPp9r63PyXZTtwEqfgYo3lmA+U0JlG+Cwl8lnqU3MEH74gM
         +1pg==
X-Gm-Message-State: ACgBeo2PGOOTNgSNcTlvOKqp+aeaWKJoWHESy5J13PkjMAmfP++8rhSe
        JUpnj0Ccd+60SMDDW9o+r18V5w==
X-Google-Smtp-Source: AA6agR7VJ8j0hKXexix+zZNZGjqFwxTKwdptIZ3mwCSF5QurOjI2nsEuLfEZ2lkPEf15lqjmVu4xMg==
X-Received: by 2002:a05:6638:3e0a:b0:34c:ff3:57ff with SMTP id co10-20020a0566383e0a00b0034c0ff357ffmr5342528jab.105.1662654051747;
        Thu, 08 Sep 2022 09:20:51 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d91-20020a0285e4000000b003584d00a0b9sm205077jai.20.2022.09.08.09.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 09:20:51 -0700 (PDT)
Message-ID: <a2db93db-4cca-5a72-62c9-75f76f19221d@kernel.dk>
Date:   Thu, 8 Sep 2022 10:20:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [GIT PULL] nvme fixes for Linux 6.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YxoLsUEjritZcoK9@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YxoLsUEjritZcoK9@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/8/22 9:35 AM, Christoph Hellwig wrote:
> The following changes since commit 748008e1da926a814cc0a054c81ca614408b1b0c:
> 
>   block: don't add partitions if GD_SUPPRESS_PART_SCAN is set (2022-09-03 11:29:03 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.0-2022-09-08

Pulled, thanks.

-- 
Jens Axboe


