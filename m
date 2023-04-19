Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D44C77B75
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 02:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjDSCQ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 22:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjDSCQ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 22:16:56 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B47040D7
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 19:16:55 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-520de6d3721so2993a12.0
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 19:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681870615; x=1684462615;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8Cwf7mS0hqiAQbvKm/d6kdWRNPIDIXo8r/9IaEH2Yo=;
        b=eB+K4BPVLT2Vml0+6TCCKXYraAAiPLDH3jdJEJ90wc8ofTtAMGRTBGsNT6OQ39tPTe
         IYb0aqw0I7c9uGVjWX99dLweZBCA+XrOuucGYq6P0HaJoeRg8utBGJ2IFwvWUEfsk971
         TB0BYWM4itBR8HO7P7zn0pw3/6BGvqLNjPVESHQE0+vO68NGKHHAwRizMQoLQ+MdHSj1
         BLfSsTHJtHC8ZyPEznq17oRuIEatWTx847eLvxJg/2cIaZHFdzSPcugeqD6jeRyauJQ8
         S4hxJCTq5go8iZvbtbhDST+KrByftmOSY90ZUEW9U+DLIc+k1kbL++UVcWnn0gI/L3xM
         BiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681870615; x=1684462615;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8Cwf7mS0hqiAQbvKm/d6kdWRNPIDIXo8r/9IaEH2Yo=;
        b=WSNJM07T/zqaVHvTmBCMJSGZbCWa2/Yk9Xryks4dxha1+llwXB3DtKLSMYWFEh2Ptf
         tUtX6wHMw/W1xYTcnTsBxttuto8w11EyGGjXIvq45L3cAaRLDMcHQfiYgZku82t9bAXU
         CeTDt7lAFr75hEdc2htqewD64Q/uYiFay50Bre3asOkkNU4ytDWX+0AFJSWcECgKVuNR
         CJGlviqbZWUVtlYXnXTuMbo368D0//VKn+r2ZqSUiyD9R7o1IzFv+cWZYrnhwRdBotw4
         9ZhOESv925Q+/nJPLoq9I3P+gM34El4iozlgomg2cF9AvpMmFacBjrKNzZs8OBLwxy6L
         QPBg==
X-Gm-Message-State: AAQBX9cdz4sIiZl6YhMQWhEHR1KA/FFnGasifE/gvaUBtlR/4KcLMfKD
        fVWpj4xREJKAuMkOhnXS/53CNmFs/nr89uMppr4=
X-Google-Smtp-Source: AKy350as3fy4qCgt2FHQwskrVVS5zzRf84hsEv15298tm/MvYUI9UbPQ7+2kCoMQ8HSYexOlS4KBVA==
X-Received: by 2002:a17:902:ea0b:b0:1a6:e00b:c3e5 with SMTP id s11-20020a170902ea0b00b001a6e00bc3e5mr9489961plg.4.1681870614705;
        Tue, 18 Apr 2023 19:16:54 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g21-20020a170902869500b001a5260a6e6csm10210138plo.206.2023.04.18.19.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 19:16:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
In-Reply-To: <20230418131810.855959-1-ming.lei@redhat.com>
References: <20230418131810.855959-1-ming.lei@redhat.com>
Subject: Re: [PATCH V3] block: ublk: switch to ioctl command encoding
Message-Id: <168187061377.411072.9389338889592369047.b4-ty@kernel.dk>
Date:   Tue, 18 Apr 2023 20:16:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 18 Apr 2023 21:18:10 +0800, Ming Lei wrote:
> All ublk commands(control, IO) should have taken ioctl command encoding
> from the beginning, because ioctl command encoding defines each code
> uniquely, so driver can figure out wrong command sent from userspace
> easily; 2) it might help security subsystem for audit uring cmd[1].
> 
> Unfortunately we didn't do that way, and it could be one lesson for
> ublk driver.
> 
> [...]

Applied, thanks!

[1/1] block: ublk: switch to ioctl command encoding
      commit: 2d786e66c9662d84cbeab981ce3a371d2fb5a4bb

Best regards,
-- 
Jens Axboe



