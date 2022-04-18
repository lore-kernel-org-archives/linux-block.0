Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028E9C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 21:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiDRVkx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 17:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiDRVkx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 17:40:53 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16FC2F002
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 14:38:11 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d14so3035278qtw.5
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 14:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=QV+hJH1FKB6oeYXhdrhNYE3vhjwwO5k5vdJcg1nlOHg=;
        b=z0erTRR5eaxtaNnV2POckTl34JtdJl0oDhfSwGiqqb0eD4rQp9/xsR4a0QVPyBLUTk
         SnZRRgtwWYeclIS5yGU7h5Ojv6Ah8I83A5Bw3Pz7154je+WZMKla5/NHBYu/RphqCY9S
         5iYpE71oYYmNNx9EF25V3FY8MUtQhbqQV3gKDkhA7ykaG1w7YLtkaof829GhO+ZCRcco
         KK8N8KHvNdlQpQE2ljJT3B45cmV1jDor4q1Xdaxf0900Eh1W/QJdOryM2q/IG1fm3yhW
         0Rs+OLlrdAgYaJ9AXRc725qmkWRDACfYhgHsPeD74+qjzOwhxSKN5qGuR4oYSrwonNG6
         ddZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QV+hJH1FKB6oeYXhdrhNYE3vhjwwO5k5vdJcg1nlOHg=;
        b=xqivxBcVKeH6G6jcBFIml5MbY3LPtf0d82EReni2e1E00qd7L2JwSOsW430wK+/iM0
         zSMqCVJlPddv/uLjCMLQ7XYODzyUJaCTacP2Wels+ycsQnNVTul9GAKyDT4abVaXB8Oa
         deNlpENkqcDIDVdbMoWdlj8jYmutXu0daIwOEDVuTASD+SGk6RDnJ7FDgkOaFFGra5af
         c2kwbLYmHVilUOvEmzyOu5kryBKeRkw+vmkqpqjuLo1b6LvUHhidua/cTuHYJ8tx9SY7
         Ge8k6N2T7JDIUp4yzptohg4SvLjeMLHGLOAJqSlGEUW2/BrpyjqizmIsi3TbDe2Fi9SE
         MUlw==
X-Gm-Message-State: AOAM531LB/VyizjKJ9wp3z+X0oLE6XOfWwp1RRMob5ATcnp9LvsMZ/lO
        bTI8BAUpj842gcMBbY6rtb/IVA==
X-Google-Smtp-Source: ABdhPJzoB0PDQ+ftOkeXabgPdhvAIKLem0LMKQ1JxM8S4i1fsl4AI77eZfOadh3UIskxucP4V0/DMA==
X-Received: by 2002:a05:622a:1392:b0:2e1:e7b9:3ce4 with SMTP id o18-20020a05622a139200b002e1e7b93ce4mr8419901qtk.153.1650317890737;
        Mon, 18 Apr 2022 14:38:10 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a424a00b00680c0c0312dsm7318026qko.30.2022.04.18.14.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 14:38:10 -0700 (PDT)
Date:   Mon, 18 Apr 2022 17:38:09 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     bvanassche@acm.org
Cc:     linux-block@vger.kernel.org
Subject: Nullblk configfs oddities
Message-ID: <Yl3aQQtPQvkskXcP@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

I'm trying to add a test to fsperf and it requires the use of nullblk.  I'm
trying to use the configfs thing, and it's doing some odd things.  My basic
reproducer is

modprobe null_blk
mkdir /sys/kernel/config/nullb/nullb0
echo some shit into the config
echo 1 > /sys/kernel/config/nullb/nullb0/power

Now null_blk apparently defaults to nr_devices == 1, so it creates nullb0 on
modprobe.  But this doesn't show up in the configfs directory.  There's no way
to find this out until when I try to mkfs my nullb0 and it doesn't work.  The
above steps gets my device created at /dev/nullb1, but there's no actual way to
figure out that's what happened.  If I do something like
/sys/kernel/config/nullb/nullbfsperf I still just get nullb<number>, I don't get
my fancy name.

I don't really care what the solution looks like, I either need to be able to
create a random name and have a symlink automatically created so I can get to
the right device node (which I don't think can be done without udev, so I'm not
fan of this) or I need a way to figure out from configfs which device my thing
actually got created as.

It would also be nice if /sys/kernel/config/nullb/nullb0 was populated at
modinfo time so I know it's there already, then I could do something silly like
get the next number and use that as my device.  Thanks,

Josef
