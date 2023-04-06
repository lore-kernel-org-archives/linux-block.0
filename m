Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29706C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 21:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbjDFVNR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjDFVNQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 17:13:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127487ED8
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 14:13:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o2so38631803plg.4
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 14:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njSASDPGxvDeRx/tOOaKUoyOzLKz0UOtOPpP/JnSh0U=;
        b=gl1YK9rXvkZgeLCNkmHOkHb3LtVpQCfsZBdO3Svvc9NcaVsP/nTbZTjqTjBP7tGxZ2
         EIiHztUOIGYTBNXlIaL5J9Sib8zweGejV0VLxAAip4Agz+F5NJOyL0321yGwwFPTUl6/
         ZacrzxLieor+LIZBA86a+Wm1T3RhfR2qWHS+jMDH9bFYZcTUehzgfO6C33Ap0uhy4hmF
         ofgFQ+rsA3uwQSWbG5Ko5B4Jo2MG+caXQAv4t0oCIPR9uwDXzm1r/9i2m4ICDs0aImrE
         hwH6dynlIpKGrs3EZCl8QJccYLT1bE9AbW3rpC99PqRP3SQhAuyteOARLCyEdYk6Tpi7
         YWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njSASDPGxvDeRx/tOOaKUoyOzLKz0UOtOPpP/JnSh0U=;
        b=lQJ5boNwSUVmCfW/+NgxbxLMp7Ypa9MQN4Ad+7b2oyoJi7FmZKJxO2TdRW3k3jcDvS
         w0V3mV/yIZwMEkKzGR77mq/4OxeV185hCP0qVV3q0vJjS69L+WldYm6JRSdmf7PK9086
         t4b3FjCyhMWERY3pKhQcjtFSRZOUFle2cE1AeRDV/PtPggXXRSMm4eDpN7WRioZHIyHd
         WTczxA7XlnTMDoykG8r38gJGluU8quJtuMLW1o4sVDd5FJtPz5e1/0Td0F6nL9H6C+X4
         vBbbBRJZ0fhkzUMfvMyyzyLtvcqSmdYvYY+1NHOl5kiWvp7b0cn/MS4rnkIz3i2BEQ52
         AR+g==
X-Gm-Message-State: AAQBX9dS1K8xE50MvXpMLF2zRjghr7sofnuVvm5ITPYME5ZpfeZamlrI
        5HQq9GQdPuQEMdsjBRWgZpr4CyB3SWQ=
X-Google-Smtp-Source: AKy350asRKmOdbUBzlpHOxby4LL0s/EQlEDRgsuKeqLA++WHaoKq7OB4yp1lkcMSi0XF5fY+eado2Q==
X-Received: by 2002:a17:90b:3849:b0:23d:4e9d:2eb0 with SMTP id nl9-20020a17090b384900b0023d4e9d2eb0mr12547715pjb.36.1680815595497;
        Thu, 06 Apr 2023 14:13:15 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id t14-20020a17090a024e00b002448f08b177sm1764259pje.22.2023.04.06.14.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:13:14 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 14:13:13 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 05/16] zram: return early on error in zram_bvec_rw
Message-ID: <ZC816QETw13lzuT4@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 04:40:51PM +0200, Christoph Hellwig wrote:
> When the low-level access fails, don't clear the idle flag or clear
> the caches, and just return.

Make sense.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Minchan Kim <minchan@kernel.org>
