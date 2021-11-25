Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A96C433EF
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 16:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356400AbhKYQU4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhKYQS4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 11:18:56 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7814BC0619EE
        for <linux-block@vger.kernel.org>; Thu, 25 Nov 2021 08:04:03 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id r2so6258933ilb.10
        for <linux-block@vger.kernel.org>; Thu, 25 Nov 2021 08:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=OkKUNCT1f1HRDTRORUnetTlpyJRQGtvGhJfeDdMLDQs=;
        b=HcMvPBm7qcTWcKrT9zGZLXAQ5tsQFl+o2FWvclvqUK6satMqQlgo9rj10CKECpSj2F
         /d42l9wbhd0uP6RnpHsRHe4+1RJ9s6cy+5pOx3tb+QJ/sUvXDD+XYSJqo+jD37X2wvut
         ggC/RsT1lmd9ltnX9naDbhfGj6ATBTyfpWn4MwTu/tI+Q/eDaZBu88sypE1cRVVZrbMV
         +G+CqxIAiL9VzDsRRNzTNAv3Ome8OXsBS6xWTwej4o0u0x/DI4zl4GLeCs/lZ9PT0qy4
         cBluWg5BtXSAMYbkQ/OGkMce7rx1EXrV0eX0eRR23XUifRwGgs5IR2IP7te6MoxCsa3S
         GHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=OkKUNCT1f1HRDTRORUnetTlpyJRQGtvGhJfeDdMLDQs=;
        b=Kjd77FqcLkW0lAV/kQTwObuyckvQD65eu4BMP5JoqdCKuZni/uyuNTaQM5M78/w92u
         MCvmHAN69pw9pFGTyODt/BPgCQVXzH6z0Ho2S1Ud+S/nJsZ9TdV5QsYx2Enqck9bj1Di
         AoX/kbSuu5ghUJTRAtzbyInBnh3O5r9LAauDCd2cKXV/SxrANL7LW+IzqqJaT4bXI47y
         SNnGE5OMD2GVnpXYBObLplSKrkQIXSKAamrpsNr0IHpskv0F35dNe8IYT3IYQwQp3adR
         rx4rqA+7d8yqJ0UR2AtHdH8+7pc7CiSUXo4tdEm4kzHppcpZrMHr0XmRgvMso156FBCj
         GjmQ==
X-Gm-Message-State: AOAM531mwwyPnu0Fm8aSZouIFVyBVJFAywBENjAPmd3wdQS3/Jr7RBFC
        5EDDM59n7Qo6+9fX6Rko4FNj0wMxEIbDBHoN
X-Google-Smtp-Source: ABdhPJxlL6fbgyT7lTn8YwOEVRCjsEx9UAwga7f5YncNxtM2FcFdDXl4gQ5WCpZFcvqXN3ffqwDGzA==
X-Received: by 2002:a05:6e02:15c4:: with SMTP id q4mr25183812ilu.133.1637856242909;
        Thu, 25 Nov 2021 08:04:02 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id y8sm1684553iox.32.2021.11.25.08.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 08:04:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jan Kara <jack@suse.cz>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org
In-Reply-To: <20211125133645.27483-1-jack@suse.cz>
References: <20211125133131.14018-1-jack@suse.cz> <20211125133645.27483-1-jack@suse.cz>
Subject: Re: [PATCH 1/8] block: Provide blk_mq_sched_get_icq()
Message-Id: <163785624040.524816.16236422623575839115.b4-ty@kernel.dk>
Date:   Thu, 25 Nov 2021 09:04:00 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 25 Nov 2021 14:36:34 +0100, Jan Kara wrote:
> Currently we lookup ICQ only after the request is allocated. However BFQ
> will want to decide how many scheduler tags it allows a given bfq queue
> (effectively a process) to consume based on cgroup weight. So provide a
> function blk_mq_sched_get_icq() so that BFQ can lookup ICQ earlier.
> 
> 

Applied, thanks!

[1/8] block: Provide blk_mq_sched_get_icq()
      commit: 4896c4e64ba5d5d5acdbcf68c5910dd4f6d8fa62
[2/8] bfq: Track number of allocated requests in bfq_entity
      commit: 421165c5bb2e7c7480290a229ea7a24512237494
[3/8] bfq: Store full bitmap depth in bfq_data
      commit: e0ef40059557df144110865953ea4c0b87c11ac5
[4/8] bfq: Limit number of requests consumed by each cgroup
      commit: 3d7a7c45e29d5d1f5a9622557acb47443e8b6e28
[5/8] bfq: Limit waker detection in time
      commit: d7eb68e3958fc91711f5df981c517fec9da35c42
[6/8] bfq: Provide helper to generate bfqq name
      commit: 2bbd0f81ac7050bfd537437a65579d49bc2128c1
[7/8] bfq: Log waker detections
      commit: e330e2ab2c40e624029cf208c9505cad2b3c81fd
[8/8] bfq: Do not let waker requests skip proper accounting
      commit: b488606166844e7fb03e5995dbc9d608bbd57c05

Best regards,
-- 
Jens Axboe


