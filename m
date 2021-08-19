Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34948C4320A
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 09:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1849D61151
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 09:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbhHSJbq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Aug 2021 05:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbhHSJbq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 05:31:46 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F81AC061575;
        Thu, 19 Aug 2021 02:31:10 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t1so5345976pgv.3;
        Thu, 19 Aug 2021 02:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=TD555ToQ7cZoDLrsFaWX+rKTsvPUaPbTlrb7wj9mN80=;
        b=uae6j5z2fYdUHB09jUyx6mGb6+vwA8vC3enxMHz5jS5429LZodtoKDe26vRjxKOMS1
         uc09m8WGq0hkh1F6/j/oeG8Zdj8JYYTcx1bhwuEbxa+j2mjxnfYSMy1AYRFmxPGlIXOT
         dyw9N9r+2X0AJLenQyE+peiEiyndWDhcY9aiJrt7pmShCjfdqA785rMa0UUeTUUmxzcP
         PPAGFxFyTkWbJj2LdySrhMiCj97905tO0YtsW9iJV+nfJYohhY5nFgvmALfZZOZf6IeZ
         CIndsfuKiE4OEu36bWS893BIIRnvJ74gaVA2fIksBxMpx0E9YnoWGb+RjQ9y2MnDgXG2
         th9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=TD555ToQ7cZoDLrsFaWX+rKTsvPUaPbTlrb7wj9mN80=;
        b=DvPlS5fQOuHRK8ZxLSBWj0q/72zkuuq5/bdQeconG0Y2QoOELuWvzcGdCFo1kWonZ0
         uyjTl68VcqihY6IkEagYbf8stsnrGFTtMWdVd7BpPmc5aKyBo2yRbpxEqM6NCTOHwoYw
         C9N0ZbmoLgAQTVBVNwJcqQWbMFXwFW1uA+yIF1LRzCQxTzpfgEpWvJgg+2CgyWPsKVZi
         mSOlIHGS+m6w1r79AThwfiUx+Tis3qATc8Glei0c1z8IMq4nHiSRJ/qOzTdtHpKRhqB5
         D7j9ZLCSNFCi44yK3/yXVIUDxfuicwbBFTaWQl7BGeHwZa9uq3ZCx33JV0h1cDe8frcN
         rzBw==
X-Gm-Message-State: AOAM532JQUaTLxqkTCpC0ILadxTCLJWOUkGlOLMGEyaGkHS8t1M4hMYe
        zN5kJ54NrtkacX5HXvbUvJKFy9+CiE4=
X-Google-Smtp-Source: ABdhPJwLhUpHhOzjgyGvwPAuNAhAfzZkmXEns11qhy89P72cp+Q5tTX74RDjS/M/frd/KzWLI+pLfg==
X-Received: by 2002:a62:76d0:0:b0:3e3:42d6:c735 with SMTP id r199-20020a6276d0000000b003e342d6c735mr958707pfc.32.1629365469368;
        Thu, 19 Aug 2021 02:31:09 -0700 (PDT)
Received: from [10.133.0.42] ([85.203.23.237])
        by smtp.gmail.com with ESMTPSA id n18sm2737978pfu.3.2021.08.19.02.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 02:31:08 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] block: drbd: four possible ABBA deadlocks
To:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <f425ae14-8857-28d7-a27a-d25da83e1bd6@gmail.com>
Date:   Thu, 19 Aug 2021 17:31:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

My static analysis tool reports four possible ABBA deadlocks in the drbd 
drivers in Linux 5.10:

### Deadlock A ###
w_after_conn_state_ch()
   mutex_lock(&connection->resource->conf_update); --> line 2065
   conn_free_crypto()
     drbd_free_sock()
       drbd_free_one_sock(&connection->data)
         mutex_lock(&ds->mutex); --> line 2967

drbd_adm_net_opts()
   mutex_lock(&connection->data.mutex); --> line 2445
   mutex_lock(&connection->resource->conf_update); --> line 2446

When w_after_conn_state_ch() and drbd_adm_net_opts() are concurrently 
executed, the deadlock can occur.

### Deadlock B ###
drbd_adm_connect()
   mutex_lock(&adm_ctx.resource->conf_update); --> line 2644
   conn_free_crypto()
     drbd_free_one_sock(&connection->data)
       mutex_lock(&ds->mutex); --> line 2967

drbd_adm_net_opts()
   mutex_lock(&connection->data.mutex); --> line 2445
   mutex_lock(&connection->resource->conf_update); --> line 2446

When drbd_adm_connect() and drbd_adm_net_opts() are concurrently 
executed, the deadlock can occur.

### Deadlock C ###
w_after_conn_state_ch()
   mutex_lock(&connection->resource->conf_update); --> line 2065
   conn_free_crypto()
     drbd_free_sock()
       drbd_free_one_sock(&connection->data)
         mutex_lock(&ds->mutex); --> line 2967

receive_protocol()
   mutex_lock(&connection->data.mutex); --> line 3778
   mutex_lock(&connection->resource->conf_update); --> line 3779

When w_after_conn_state_ch() and receive_protocol() are concurrently 
executed, the deadlock can occur.

### Deadlock D ###
drbd_adm_connect()
   mutex_lock(&adm_ctx.resource->conf_update); --> line 2644
   conn_free_crypto()
     drbd_free_one_sock(&connection->data)
       mutex_lock(&ds->mutex); --> line 2967

receive_protocol()
   mutex_lock(&connection->data.mutex); --> line 3778
   mutex_lock(&connection->resource->conf_update); --> line 3779

When drbd_adm_connect() and receive_protocol() are concurrently 
executed, the deadlock can occur.

I am not quite sure whether these possible deadlocks are real and how to 
fix them if they are real.
Any feedback would be appreciated, thanks

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>


Best wishes,
Jia-Ju Bai
