Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21420C43334
	for <linux-block@archiver.kernel.org>; Fri,  8 Jul 2022 16:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiGHQcp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jul 2022 12:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbiGHQcd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jul 2022 12:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3544D10EF
        for <linux-block@vger.kernel.org>; Fri,  8 Jul 2022 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657297951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=9nTNsJPilxKSjsFmeLfoVK6rg+4vFMVjfLmCxFTwugI=;
        b=UKehbpBd6VngdFtpYSYrxB/rOArNakS7TFqAZHBti6pRTJfK/B9+GWOno2VYamEyiGTQTM
        lTydy1fIxCRrYQt9Y+kKVTVP4RIegeR3U/Cm47QhX/1jVm/+5ZW5A3P094BegGxBlCA+0B
        dDEL10plwJwuL9XlcX94DAz14QVhJYs=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-TBoDpE8SMoKkGc70wogW-w-1; Fri, 08 Jul 2022 12:32:30 -0400
X-MC-Unique: TBoDpE8SMoKkGc70wogW-w-1
Received: by mail-pg1-f198.google.com with SMTP id bd7-20020a656e07000000b00412a946da8eso4854429pgb.20
        for <linux-block@vger.kernel.org>; Fri, 08 Jul 2022 09:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9nTNsJPilxKSjsFmeLfoVK6rg+4vFMVjfLmCxFTwugI=;
        b=dc0d//uXxz9X79hJDyn6zC02+7vdbENuoADl6iIR1QGNC+vCtFMIFRfFxpxdq+aMH+
         1sIHE9Y5AZHR/vBNqmev7b0jqzB5JYP6Z9r6ZdWXmXmdW1OORiDCCh811iHPD3WJXSu8
         n9X8QnPLa5C3v9s9olv2Wp0ulUKPtG10AQ2oDoINiyC4ynLlapzj7LEirQJ0FoYa8cBO
         1XW8KFQ7KFJP1e87u3/DhakmRdugfOapdHaVrB5pRphgEjfIGDxjGYaGvHQ+2n7eHo7u
         2XUn/y0SLvFZpeapyhrgkusXlUK+suOH8RYnV6tbtQHFSSGxYn8TYi4XTNDymxVXFPNd
         3WqA==
X-Gm-Message-State: AJIora+c2axfkKflXtlUtLxKy4E7EXxsxmLyawiWEaCn5H/N/ULCsLRy
        rGBZc38xkhtRwXHoaszes+ispm7xxbxl9Dpl8l05UEPNkqpuZERNpmAUPNPWjt7UK3pk9l0lgA7
        kINMzAXjfaqrXX1a12zIFbaM8dViIl3FWloKUP1U=
X-Received: by 2002:a17:902:f60b:b0:16a:2dcf:989d with SMTP id n11-20020a170902f60b00b0016a2dcf989dmr4582250plg.90.1657297948727;
        Fri, 08 Jul 2022 09:32:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ua96ynrZ4qItbRqHCIMf2P0YnsecQXFjqOLVL9V4PAaak1XiDh6bykwCb2O0npf6mk7BxSgcWYK7GtDe5lmb4=
X-Received: by 2002:a17:902:f60b:b0:16a:2dcf:989d with SMTP id
 n11-20020a170902f60b00b0016a2dcf989dmr4582146plg.90.1657297947227; Fri, 08
 Jul 2022 09:32:27 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sat, 9 Jul 2022 00:32:15 +0800
Message-ID: <CAHj4cs9Jhg4DZRnck_rdGWtpv9nLTAF__CVtPQu9vViVUZ-Odg@mail.gmail.com>
Subject: [bug report] blktests nvme/005 trigered debugfs: Directory 'hctx0'
 with parent '/' already present!
To:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello
I found below error log when I ran blktests nvme/ tests on aarch64
with the latest linux-block/for-next,
Please help check it, and feel free to let me know if you need any
info/test for it, thanks.

[ 3814.423360] run blktests nvme/005 at 2022-07-08 07:38:17
[ 3814.565071] loop0: detected capacity change from 0 to 2097152
[ 3814.587169] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 3814.601727] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 3814.626848] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:90390a00-4597-11e9-b935-3c18a0043981.
[ 3814.642802] nvme nvme0: creating 32 I/O queues.
[ 3814.659147] nvme nvme0: mapped 32/0/0 default/read/poll queues.
[ 3814.675934] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420
[ 3815.906399] nvmet: creating nvm controller 2 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:90390a00-4597-11e9-b935-3c18a0043981.
[ 3815.921954] nvme nvme0: creating 32 I/O queues.
[ 3815.959703] nvme nvme0: mapped 32/0/0 default/read/poll queues.
[ 3815.966140] debugfs: Directory 'hctx0' with parent '/' already present!
[ 3815.972788] debugfs: Directory 'hctx1' with parent '/' already present!
[ 3815.979399] debugfs: Directory 'hctx2' with parent '/' already present!
[ 3815.986026] debugfs: Directory 'hctx3' with parent '/' already present!
[ 3815.992672] debugfs: Directory 'hctx4' with parent '/' already present!
[ 3815.999282] debugfs: Directory 'hctx5' with parent '/' already present!
[ 3816.005916] debugfs: Directory 'hctx6' with parent '/' already present!
[ 3816.013558] debugfs: Directory 'hctx7' with parent '/' already present!
[ 3816.020168] debugfs: Directory 'hctx8' with parent '/' already present!
[ 3816.026801] debugfs: Directory 'hctx9' with parent '/' already present!
[ 3816.033430] debugfs: Directory 'hctx10' with parent '/' already present!
[ 3816.040125] debugfs: Directory 'hctx11' with parent '/' already present!
[ 3816.046833] debugfs: Directory 'hctx12' with parent '/' already present!
[ 3816.056686] debugfs: Directory 'hctx13' with parent '/' already present!
[ 3816.063423] debugfs: Directory 'hctx14' with parent '/' already present!
[ 3816.070269] debugfs: Directory 'hctx15' with parent '/' already present!
[ 3816.077064] debugfs: Directory 'hctx16' with parent '/' already present!
[ 3816.083798] debugfs: Directory 'hctx17' with parent '/' already present!
[ 3816.090643] debugfs: Directory 'hctx18' with parent '/' already present!
[ 3816.097431] debugfs: Directory 'hctx19' with parent '/' already present!
[ 3816.104216] debugfs: Directory 'hctx20' with parent '/' already present!
[ 3816.110950] debugfs: Directory 'hctx21' with parent '/' already present!
[ 3816.117674] debugfs: Directory 'hctx22' with parent '/' already present!
[ 3816.124412] debugfs: Directory 'hctx23' with parent '/' already present!
[ 3816.131303] debugfs: Directory 'hctx24' with parent '/' already present!
[ 3816.138019] debugfs: Directory 'hctx25' with parent '/' already present!
[ 3816.144739] debugfs: Directory 'hctx26' with parent '/' already present!
[ 3816.151451] debugfs: Directory 'hctx27' with parent '/' already present!
[ 3816.158147] debugfs: Directory 'hctx28' with parent '/' already present!
[ 3816.164862] debugfs: Directory 'hctx29' with parent '/' already present!
[ 3816.171569] debugfs: Directory 'hctx30' with parent '/' already present!
[ 3816.178263] debugfs: Directory 'hctx31' with parent '/' already present!
[ 3816.209654] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[ 3816.371107] block nvme0n1: no available path - failing I/O
[ 3816.376724] block nvme0n1: no available path - failing I/O
[ 3816.382227] Buffer I/O error on dev nvme0n1, logical block 0, async page read

[ 4508.175060] run blktests nvme/022 at 2022-07-08 07:49:51
[ 4508.308626] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 4508.336571] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 4508.362149] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:90390a00-4597-11e9-b935-3c18a0043981.
[ 4508.378077] nvme nvme0: creating 32 I/O queues.
[ 4508.394236] nvme nvme0: mapped 32/0/0 default/read/poll queues.
[ 4508.411370] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420
[ 4509.544769] nvme nvme0: resetting controller
[ 4509.652901] nvmet: creating nvm controller 2 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:90390a00-4597-11e9-b935-3c18a0043981.
[ 4509.668327] nvme nvme0: creating 32 I/O queues.
[ 4509.704724] nvme nvme0: mapped 32/0/0 default/read/poll queues.
[ 4509.711164] debugfs: Directory 'hctx0' with parent '/' already present!
[ 4509.717803] debugfs: Directory 'hctx1' with parent '/' already present!
[ 4509.724413] debugfs: Directory 'hctx2' with parent '/' already present!
[ 4509.731042] debugfs: Directory 'hctx3' with parent '/' already present!
[ 4509.737671] debugfs: Directory 'hctx4' with parent '/' already present!
[ 4509.744282] debugfs: Directory 'hctx5' with parent '/' already present!
[ 4509.750916] debugfs: Directory 'hctx6' with parent '/' already present!
[ 4509.757526] debugfs: Directory 'hctx7' with parent '/' already present!
[ 4509.764154] debugfs: Directory 'hctx8' with parent '/' already present!
[ 4509.770782] debugfs: Directory 'hctx9' with parent '/' already present!
[ 4509.777392] debugfs: Directory 'hctx10' with parent '/' already present!
[ 4509.784102] debugfs: Directory 'hctx11' with parent '/' already present!
[ 4509.790809] debugfs: Directory 'hctx12' with parent '/' already present!
[ 4509.797503] debugfs: Directory 'hctx13' with parent '/' already present!
[ 4509.804209] debugfs: Directory 'hctx14' with parent '/' already present!
[ 4509.810921] debugfs: Directory 'hctx15' with parent '/' already present!
[ 4509.817627] debugfs: Directory 'hctx16' with parent '/' already present!
[ 4509.824322] debugfs: Directory 'hctx17' with parent '/' already present!
[ 4509.831030] debugfs: Directory 'hctx18' with parent '/' already present!
[ 4509.837742] debugfs: Directory 'hctx19' with parent '/' already present!
[ 4509.844437] debugfs: Directory 'hctx20' with parent '/' already present!
[ 4509.852937] debugfs: Directory 'hctx21' with parent '/' already present!
[ 4509.859677] debugfs: Directory 'hctx22' with parent '/' already present!
[ 4509.866437] debugfs: Directory 'hctx23' with parent '/' already present!
[ 4509.873151] debugfs: Directory 'hctx24' with parent '/' already present!
[ 4509.879861] debugfs: Directory 'hctx25' with parent '/' already present!
[ 4509.886555] debugfs: Directory 'hctx26' with parent '/' already present!
[ 4509.893266] debugfs: Directory 'hctx27' with parent '/' already present!
[ 4509.899978] debugfs: Directory 'hctx28' with parent '/' already present!
[ 4509.906673] debugfs: Directory 'hctx29' with parent '/' already present!
[ 4509.913394] debugfs: Directory 'hctx30' with parent '/' already present!
[ 4509.920103] debugfs: Directory 'hctx31' with parent '/' already present!
[ 4509.954557] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[ 4510.117886] block nvme0n1: no available path - failing I/O
[ 4510.123413] block nvme0n1: no available path - failing I/O
[ 4510.128913] Buffer I/O error on dev nvme0n1, logical block 0, async page read

-- 
Best Regards,
  Yi Zhang

