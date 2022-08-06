Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B73EC19F2D
	for <linux-block@archiver.kernel.org>; Sat,  6 Aug 2022 14:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiHFOv5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Aug 2022 10:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiHFOv5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Aug 2022 10:51:57 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1114E1274B
        for <linux-block@vger.kernel.org>; Sat,  6 Aug 2022 07:51:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t2so4999988ply.2
        for <linux-block@vger.kernel.org>; Sat, 06 Aug 2022 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ZHZGZq6h+lUo2eCrK9NN33tawRm/nou4eWvVvyVV5/g=;
        b=IBJCY8eQMmxSsTRzXC8fUR9mMTETadx7Dc7FFAwqZFyNrLd21rO/zwCCeRr3O4SsXU
         rRPG0BDeoL5+W0aNiX5rhkC+XKA8YS4/LZr5KxNs/6ngYmStUJPywy459UgvTwoTUCq8
         K3YDkmWP3h8cTknXLO8Ns0Sc9LPkFzKLyVYxZqRQtXVBBOdEegG5EtUs2PLPAUlPbRZy
         5FYEtkqxHT7QPWyUy3n7AsLfsjhjEI6FeqD2b1IUy4RmvjgaXdSnj8Vy/MWW4nJaITNY
         V3gfPD17xAHYLTAZ/0ihbLyddkJmNk7nChXr9zWbZf8dEOgL04rXZMclXiHMrHn50kB9
         8lWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ZHZGZq6h+lUo2eCrK9NN33tawRm/nou4eWvVvyVV5/g=;
        b=XkIsyfgRgm6EaiLXKQrCyA8kV8TWEGg2ZjjaUAy5Iqx8u2R3ui9elssEymk0vZXcs/
         DJu2Khhz8xlWF4YhMDMAdubPnVQ+WtLPn3dP+eDTWOIQ+hj8+BPSU6gduWgrUXQ7xxcH
         L70y4dAT0+w3UbBjDZ9MJU/SfY9N0z9so8QfsTME2XMUop0scHQ0UYOpXgG9h3eAABv8
         SiBXZVKLeR2Ke3Ap1TbnbGEWmfiwVi96zxmcQfdGrLp9Yj8HtKA21HTGTO/zHbEJ4/tU
         EBOWoi0vw+9khR/0TPKe8tSXtphVRzlPi9XyrntahhkpbFGsGet/6zFhwkXKkBKyxyX8
         JApQ==
X-Gm-Message-State: ACgBeo0qwhDSmZvoQlNQr3L5OzwbBKtLLYa6LGjplo+iv/ee0DfEueDY
        px7G8BPSKWWz8WFRqFASB0sQUw==
X-Google-Smtp-Source: AA6agR5tB1lfDWW5CK6g4gZATc2POoUrGVodj3DAFSvqGlbMXd9oczcdSfywNEA6LKlI4avxeOne+w==
X-Received: by 2002:a17:902:bd08:b0:16d:4230:cb45 with SMTP id p8-20020a170902bd0800b0016d4230cb45mr11344547pls.59.1659797514464;
        Sat, 06 Aug 2022 07:51:54 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o187-20020a625ac4000000b0052ef9556f47sm1527411pfb.40.2022.08.06.07.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 07:51:53 -0700 (PDT)
Message-ID: <026c2c04-aec2-0a8c-ed96-f31ae0918b2e@kernel.dk>
Date:   Sat, 6 Aug 2022 08:51:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RESEND 1/1] loop: introduce LO_FLAGS_NODEALLOC
Content-Language: en-US
To:     Zhang Boyang <zhangboyang.id@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20220806114943.8754-1-zhangboyang.id@gmail.com>
 <20220806114943.8754-2-zhangboyang.id@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220806114943.8754-2-zhangboyang.id@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/6/22 5:49 AM, Zhang Boyang wrote:
> Previously, for file-backed loop devices, REQ_OP_DISCARD and
> REQ_OP_WRITE_ZEROES (without REQ_NOUNMAP) are implemented using
> fallocate(FALLOC_FL_PUNCH_HOLE), which will cause the underlying file to
> be sparse and disk space freed. The users have no choice to prevent this
> this from happening.
> 
> This patch introduces LO_FLAGS_NODEALLOC. With this flag set,
> REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES are forced to use
> fallocate(FALLOC_FL_ZERO_RANGE). The disk space of underlying file is
> kept allocated. This is useful if users, for example, want to use a
> preallocated file as the backing file.

Just in terms of readability, I would prefer if NO_DEALLOC is used
consistently rather than NODEALLOC. The latter reads more like
node-alloc to me.

-- 
Jens Axboe

