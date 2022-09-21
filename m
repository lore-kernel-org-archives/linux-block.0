Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65462C6FA82
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 14:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiIUOhG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 10:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIUOhF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 10:37:05 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C0F8E9A6
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 07:37:05 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id v1so1123742ilq.1
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 07:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=OQpVPul4C5we8Fexj/aSQtbXO1mS4YdxkXffmvwYJ98=;
        b=KVdRsFdyh1l3a2vSue2Y3sHIUhCcvgFK5PCAM1i7jB4Wl8kCEf6JWsJhO4ow/7Vst8
         zpHiSTOfGqsPshT1tiMjwnsHrfikQFsPE6RljybkS+QLazItk9flDBGSxtI6ErAMr5TH
         9WIdSR5qsBIJF2mSoVl/+24vt6gaOKLzpthXa12eZA4PL7DloRhSTC1j14XfQGiqlMq7
         6vWp5vbDtrD59e6lfJ715Ju7g5izUuzH6hF0ym2+Fkh5QRFvX9xGoYQeIVhoNVbh0wCN
         /qLAfekd9H3cfoDOFLmxWmgkIupeiFtgsNLbNJFQf5WtzSV80IDbBegfJMrMjC6zYDvA
         wsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OQpVPul4C5we8Fexj/aSQtbXO1mS4YdxkXffmvwYJ98=;
        b=bs9CakSj4hUfsV1NuBfPZYCryetCcintT0TJNOWd1/bG+N+qKYL7K0pTufhxP7qc31
         asRiGd7SrE4e4KHrH4tSPK0YgqJa+NSz3cQ4i1DfyUA6SA3h4qKPsIlhzk3pfNFuQp/b
         nUkorIVL1MCo/rDql781Ja2WFRYPeBNIKKC6cSnEFStR3LJMAi2bMSu7c3+dxJ3eb8i5
         u3chwQf8yky1iLBcYTm0O7IweQ/wq8gfgr9k+nm5Mrkb7lBRY8spDAdWQp3YY3QPAkVJ
         fzZkQPjvTp9WFPF/ilECWRKLI1j37x0N1nb8XFnkK258lFosvcH80ovhLnZ04h/Mcb4s
         bgHQ==
X-Gm-Message-State: ACrzQf0N7kG9k4qt6ANpxReAiWK5+jD6MmUPxEBusdfN+3HUe2EQ4h/U
        9ZXgA3h4e/4A2sCtzqrxG7dAgJ5nYP5ogQ==
X-Google-Smtp-Source: AMsMyM7oYtPllSkFh7fxhMie5uDBwD9FZN63oGEkZcu6110JcxyBPZP9xcd88IhXDnuSe5mHKwFZxA==
X-Received: by 2002:a05:6e02:144e:b0:2f5:412e:7d1b with SMTP id p14-20020a056e02144e00b002f5412e7d1bmr9235515ilo.196.1663771024159;
        Wed, 21 Sep 2022 07:37:04 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e15-20020a026d4f000000b003435c50f000sm1137113jaf.14.2022.09.21.07.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 07:37:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>
In-Reply-To: <20220920200626.3422296-1-bvanassche@acm.org>
References: <20220920200626.3422296-1-bvanassche@acm.org>
Subject: Re: [PATCH] block: Fix the enum blk_eh_timer_return documentation
Message-Id: <166377102300.42759.321393830156567185.b4-ty@kernel.dk>
Date:   Wed, 21 Sep 2022 08:37:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 20 Sep 2022 13:06:26 -0700, Bart Van Assche wrote:
> The documentation of the blk_eh_timer_return enumeration values does not
> reflect correctly how e.g. the SCSI core uses these values. Fix the
> documentation.
> 
> 

Applied, thanks!

[1/1] block: Fix the enum blk_eh_timer_return documentation
      commit: b2bed51a5261f4266ecb857bba680a7f668d3ddf

Best regards,
-- 
Jens Axboe


