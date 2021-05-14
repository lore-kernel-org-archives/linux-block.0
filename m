Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6FEC43460
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 08:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE8161454
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 08:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhENIaK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 04:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbhENIaI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 04:30:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6AFC061574
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 01:28:56 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c17so24163857pfn.6
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 01:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zziB8fnKkAPk5cOUrIoEmNcES6xnR3CMs0HRIrHl5Qw=;
        b=ms8u/XnqapGMFB3Bmuv7MVt7SgIKznhOETrPe/P/fwQZJflTAUpQAcmydY60MWTt7F
         H1t+/0tPhxx7urKkPNB5KdlkgLRkczNNN+/0VuofAdLl38hCzPv7K29FOo5JvmKnWAJ0
         IoaKeShBg8nDObTAeoIubpTbkX4cw7LP0gENH3CavMYED3pmv9+DXlhRpdjY/cwmN+yS
         sGBVozui0gNkQki9a+MFt8rF/fQVRRwD/J4+Uw76KYEvkMzjvxDP2NNGE+jMsX6Mg3qq
         2NDiWooFSF8q+NJLjDkeXtnTyYQSrgo+ewOyf8juFR18B6QhftWt/eWQYX/C6+dSICZI
         E+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zziB8fnKkAPk5cOUrIoEmNcES6xnR3CMs0HRIrHl5Qw=;
        b=P3F4kzG1/iZtwUR2QiAHdn8s4sAFQ3czivmMuXbLOE2k9r5lCFay/bgWfl9qL7C6c+
         Ij+YIfMCyTNM3GNL7nAuBI1GyEdwY0GX5ikQhzpPD2yei8A6fO2PiJVZ9o6STowutp6B
         PjSefh+w5wA3vb5eb351j1ICeY5KP/Wt943n0bstbA20ixP/LTa5zbeDG0oId8VTTRaQ
         s38/2oATBmbukpB3ZDJCIa/8LqFV9YXpZGmx+mojSVPkVSMegXBxKCmOyU2nL1oUbKxQ
         cKQbRV+DQiUDRsQtG/J0vFHfXsEelgJK3qE0/ClVAyq5MkJp/1FMjO5bHSXeFxXClcxH
         w4Ng==
X-Gm-Message-State: AOAM533Lho4e2acidS6mrbBTIu1LhzA6XA78rEf94W/y82xmUKYp/DXk
        qlyT8Ub0epaAANbN1/NRsXvoo6H8DEgl1lGKXUef67hJmSFlyw==
X-Google-Smtp-Source: ABdhPJzKehHVF2/JvjoVzd/3fHLSW9FVZR0RPPaYoxj4QkAgCL3Eodmz8M6hBwtwG58zxfk1LuRRRw5elyM3nikg3Rg=
X-Received: by 2002:a63:1e55:: with SMTP id p21mr8932025pgm.412.1620980936509;
 Fri, 14 May 2021 01:28:56 -0700 (PDT)
MIME-Version: 1.0
From:   Yiyuan guo <yguoaz@gmail.com>
Date:   Fri, 14 May 2021 16:28:47 +0800
Message-ID: <CAM7=BFrvCdsW1xekOb9QAdVkhRAU6kdg1g98OUz6YYyXOuMZRg@mail.gmail.com>
Subject: A possible divide by zero bug in blk_mq_map_queues
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Yiyuan guo <yguoaz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In block/blk-mq-cpumap.c, blk_mq_map_queues has the following code:

int blk_mq_map_queues(struct blk_mq_queue_map *qmap) {
    ...
    unsigned int nr_queues = qmap->nr_queues;
    unsigned q = 0;
    ...
    for_each_present_cpu(cpu) {
        if (q >= nr_queues)
            break;
        ...
    }

    for_each_possible_cpu(cpu) {
        ...
        if (q < nr_queues) {
            map[cpu] = queue_index(qmap, nr_queues, q++);
        } else {
           ...
            if (first_sibling == cpu)
                map[cpu] = queue_index(qmap, nr_queues, q++);

        }
    }
}

if qmap->nr_queues equals to zero when entering the function, then by
passing zero to function queue_index we have a divide by zero bug:

static int queue_index(struct blk_mq_queue_map *qmap,
               unsigned int nr_queues, const int q)
{
    return qmap->queue_offset + (q % nr_queues);
}

It seems possible to me that qmap->nr_queues may equal zero because
this field is explicitly checked in other functions.

For example, in the function blk_mq_map_swqueue (block/blk-mq.c),
there is a check comparing nr_queues with 0:

for (j = 0; j < set->nr_maps; j++) {
            if (!set->map[j].nr_queues) {
                ...
                continue;
            }
            ...
}
