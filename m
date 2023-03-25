Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FA6C6FD1F
	for <linux-block@archiver.kernel.org>; Sat, 25 Mar 2023 16:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjCYQbN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Mar 2023 12:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjCYQbM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Mar 2023 12:31:12 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1CA1040D
        for <linux-block@vger.kernel.org>; Sat, 25 Mar 2023 09:31:09 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id r7-20020a17090b050700b002404be7920aso3774737pjz.5
        for <linux-block@vger.kernel.org>; Sat, 25 Mar 2023 09:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679761869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+bI22aDTE0EkyKzjY2GnUSfGRlBjHkkpYNcu06n1Jk=;
        b=x8iTMmuqo37cYf96cmXwUVtHgyEsdAfivIZbMJkaWUSxa3h/d4pdSQst0hZ2DEWY45
         DAbVKaTxmvfnbrSwVSV0nUNx/PvEoWUzX9Jy3/chG2YUAEq2JkIMfsndKbJDz+3mHi8D
         oLo5vIVlNLdl9uKdCD7ZJu2bfpgjrHGhRhOYOQuMjitjM1I/y7lu6IjPutEDfb9CQkY/
         9XQBoWGYS5sn9w4YmtZfuoB7VWwrvZWfWIc/+kMtoW8i70YkzdHj7O/DoL805auSfeeB
         rDQyGi1uF+UfRFfDyVQ68Lv3qt6KIZXMv8Dab/QT+RHU18LS2NpBXV0XeV6kTOT1Qru4
         Ec2Q==
X-Gm-Message-State: AAQBX9elTTjF1kEaSLzFnVMByKhdeStEJ4kJjHAxuutuKF0tx5dN1r3M
        8uhL3MhOuqj7fSVHBVa/kps=
X-Google-Smtp-Source: AKy350bNTQPjMRlfFTmi0UAzCZFnD81+N+Y2gpBdVOCYbojy6uZiJfu8twOr6+uP/ykU4/grtRZoBg==
X-Received: by 2002:a17:90a:780e:b0:23f:d7ea:6212 with SMTP id w14-20020a17090a780e00b0023fd7ea6212mr6257782pjk.38.1679761868613;
        Sat, 25 Mar 2023 09:31:08 -0700 (PDT)
Received: from ?IPV6:2601:642:4c02:3681:3ba2:71db:559e:27be? ([2601:642:4c02:3681:3ba2:71db:559e:27be])
        by smtp.gmail.com with ESMTPSA id mv21-20020a17090b199500b0023d16f05dd8sm4854732pjb.36.2023.03.25.09.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 09:31:07 -0700 (PDT)
Message-ID: <7f4463c1-fd02-8ac5-16d7-61ffe6279e07@acm.org>
Date:   Sat, 25 Mar 2023 09:31:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230317195938.1745318-3-bvanassche@acm.org>
 <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
 <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org>
 <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com>
 <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org>
 <20230321055537.GA18035@lst.de>
 <100dfc73-d8f3-f08f-e091-3c08707e95f5@acm.org>
 <20230323082604.GC21977@lst.de>
 <acd13f8c-6cbe-a14d-e3b4-645d62811cec@opensource.wdc.com>
 <122cdca2-b0ae-ce74-664d-e268fe0699a8@acm.org>
 <7a795b9b-51dc-9166-1cf0-6c51db77b195@opensource.wdc.com>
 <1e65e542-e8e9-bd3f-6ff1-1bbd4716a8c3@acm.org>
 <e83d1111-1841-7b2a-973b-16bea2e789c6@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e83d1111-1841-7b2a-973b-16bea2e789c6@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/23 19:00, Damien Le Moal wrote:
> The trick here could be to have the UFS LLD to unlock the target zone of a write
> when the command is sent to the device, instead of when the command completes.
> This way, the zone is still locked when there is a requeue and there is no
> reordering. That could allow for write qd > 1 in the case of UFS. And this
> method could actually work for regular writes too.

Hi Damien,

Although the above sounds interesting to me, I think the following two 
scenarios are not handled by the above approach and can lead to reordering:
* The SCSI device reporting a unit attention.
* The SCSI device responding with the SCSI status "BUSY". The UFS 
standard explicitly allows this. From the UFS standard: "If the unit is 
not ready to accept a new command (e.g., still processing previous 
command) a STATUS response of BUSY will be returned."

Thanks,

Bart.


