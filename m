Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610C6C433F5
	for <linux-block@archiver.kernel.org>; Sun, 12 Sep 2021 21:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C15C61029
	for <linux-block@archiver.kernel.org>; Sun, 12 Sep 2021 21:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbhILV3n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Sep 2021 17:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53106 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235034AbhILV3n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Sep 2021 17:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631482108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UXzUdR6U8suHlpakGn0u6PoyE/1AzfIBYfg+/BqCM08=;
        b=ZtDLqMUop+dhxQ6fG+km6Hsu1YDHeko7V9axXgVFMKdRuwuTYnP1e7wIWHmRLkeE8d85Gz
        vl+oxkE75ZmwsItVePKb7Tw1/QBHpZrdDKLgzw8oWp4HTy4J2rl/yqSb5VGYW3uE3W+I6O
        KL5ftjHq5nw7HYyr2BRt/41m3M/smmQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-0YgvCGYuPNmW2clZEcX1yw-1; Sun, 12 Sep 2021 17:28:27 -0400
X-MC-Unique: 0YgvCGYuPNmW2clZEcX1yw-1
Received: by mail-qk1-f198.google.com with SMTP id k12-20020a05620a0b8c00b003d5c8646ec2so39641886qkh.20
        for <linux-block@vger.kernel.org>; Sun, 12 Sep 2021 14:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXzUdR6U8suHlpakGn0u6PoyE/1AzfIBYfg+/BqCM08=;
        b=WGfmNTb1o3i8g+XpzXEpOCSdTSdwNSBWfNSUtkQKocF+G2v4RNx8QJ2fzTK8yF/bt9
         ZvcEThrqq/xUDgrpzFKTrBtqCkEtD74FNqi4ZPk34e5BUYM6dUkFeGdCQNYYyRLIXUJ1
         ih5t4EsJ8PLlB6KXioFMJd50Wvk0ADjxPjrM5BZwN3eLRN4xr9OngqbPwL83bAlLgp+O
         c44JFHNSn1oEXNdDDwXL+89wH7gOCjeyDqOHymddi058nySHnjsnwxpKJsPs4NvNt1Gn
         E6+pmQft82GCf+yXLdb8Otiag22NCiB6QO8QMPuohMuK1hnflKtkZRH1H8vJ2QH+/icB
         4HSQ==
X-Gm-Message-State: AOAM530/lcDW5vviIgfsj3j60iGtaNtwbV/D7zoMycS4km3ogWHeNysd
        YLKXxFXuWmLZzAycJzYvAVhlIx+Q5HHfmOz73suWad51DshCS4HJYH1T+4mwxvaQ4k7XSt7TBco
        wAtzvcOPeIbSi5faNedDH6gI=
X-Received: by 2002:a05:622a:551:: with SMTP id m17mr3676337qtx.119.1631482106427;
        Sun, 12 Sep 2021 14:28:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp3w18FCgzwQ0WuekrvBXvs2sH+o2qYs8hX/OzlEdjHrpNR8I2ga6jHGL2yoK7/wYU74JeLQ==
X-Received: by 2002:a05:622a:551:: with SMTP id m17mr3676318qtx.119.1631482106091;
        Sun, 12 Sep 2021 14:28:26 -0700 (PDT)
Received: from loberhel ([2600:6c64:4e7f:cee0:71ca:1cfd:6317:9767])
        by smtp.gmail.com with ESMTPSA id g12sm3718141qkm.112.2021.09.12.14.28.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Sep 2021 14:28:25 -0700 (PDT)
Message-ID: <c5db85b3ecb9730d848b2c37c975b72acd8a2413.camel@redhat.com>
Subject: Re: [bug report] blktests srp/013 lead kernel panic with latest
 block/for-next and 5.13.15
From:   Laurence Oberman <loberman@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     CKI Project <cki-project@redhat.com>
Date:   Sun, 12 Sep 2021 17:28:24 -0400
In-Reply-To: <059007be-03fa-5948-d86d-d1750587e894@acm.org>
References: <CAHj4cs8XNtkzbbiLnFmVu82wYeQpLkVp6_wCtrnbhODay+OP9w@mail.gmail.com>
         <059007be-03fa-5948-d86d-d1750587e894@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 2021-09-12 at 14:25 -0700, Bart Van Assche wrote:
> On 9/12/21 09:26, Yi Zhang wrote:
> > [  130.851918] Failing address: 000003ff80815000 TEID:
> > 000003ff80815803
> > [  130.852068] CPU: 1 PID: 950 Comm: multipathd Not tainted 5.14.0
> > #1
> > [  130.852071] Hardware name: IBM 8561 LT1 400 (KVM/Linux)
> > [  130.852073] Krnl PSW : 0704e00180000000 000000002e37e7cc
> > (scsi_mq_exit_request+0x2c/0x58)
> > [  130.852113] Call Trace:
> > [  130.852115]  [<000000002e37e7cc>] scsi_mq_exit_request+0x2c/0x58
> > [  130.852120]  [<000000002e1c2608>] blk_mq_free_rqs+0x80/0x218
> > [  130.852125]  [<000000002e1c2f0a>] blk_mq_free_tag_set+0x5a/0x128
> > [  130.852128]  [<000000002e3774d0>]
> > scsi_host_dev_release+0xb0/0x118
> > [  130.852130]  [<000000002e33fe10>] device_release+0x48/0xb0
> > [  130.852136]  [<000000002e28bf12>] kobject_put+0xca/0x1f0
> > [  130.852140]  [<000000002e33fe10>] device_release+0x48/0xb0
> > [  130.852142]  [<000000002e28bf12>] kobject_put+0xca/0x1f0
> > [  130.852145]  [<000000002dc1324a>]
> > execute_in_process_context+0x4a/0xf0
> > [  130.852149]  [<000000002e33fe10>] device_release+0x48/0xb0
> > [  130.852151]  [<000000002e28bf12>] kobject_put+0xca/0x1f0
> > [  130.852153]  [<000000002e38e49e>] sd_release+0x6e/0xf8
> > [  130.852158]  [<000000002e1a86d0>] blkdev_put+0xe0/0x278
> > [  130.852162]  [<000000002e1a9946>] blkdev_close+0x3e/0x50
> > [  130.852164]  [<000000002de94728>] __fput+0xa0/0x280
> > [  130.852168]  [<000000002dc19190>] task_work_run+0x88/0xd0
> > [  130.852170]  [<000000002dc89b9e>]
> > exit_to_user_mode_loop+0x1ce/0x1d8
> > [  130.852175]  [<000000002dc89c22>]
> > exit_to_user_mode_prepare+0x7a/0x80
> > [  130.852178]  [<000000002e6e70be>] __do_syscall+0x106/0x1e8
> > [  130.852181]  [<000000002e6f5518>] system_call+0x78/0xa0
> 
> I haven't seen this yet. Is this crash reproducible? If so, please
> bisect this crash.
> 
> Thanks,
> 
> Bart.
> 

I am looking to reproduce and bisect as well.
Regards
Laurence

