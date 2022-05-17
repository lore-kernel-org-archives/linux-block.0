Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41630C433EF
	for <linux-block@archiver.kernel.org>; Tue, 17 May 2022 12:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345318AbiEQMMK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 May 2022 08:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345077AbiEQMMJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 May 2022 08:12:09 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5A44578A
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 05:12:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l14so6266823pjk.2
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 05:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=bESFS7Lce2ivS8jPv+1Tsk70w8y9oJwx0ecowrteEFU=;
        b=Y/MfMz7lk/eOpLKlFlTXgPsjibZmZaA2PbI2ucwBhDPfX/hEp9tUApYImhcgzuuYOF
         FOt0+nc+MCLbeqbOXV3FgGF3xcRDDx1sxrxkzBONsxm444eMwKGqx9Wj7nayWIJL9beT
         2QbsV6YhW75anjz5V+Xj6lKrjs26H0gANnVDdG960Z/4Y/C8knzq0Y9I2vc/PpdEnMeZ
         Er8qwMap1HyKGi9GB839aP0LGjuJNKfmJ+iP10ioCUykBwDlM0Dhj848G3NO13ISNqHw
         FbbnrNHoZK1jN2MLWHhJf/T5K2MCHbpv7+Up7vjLRjEbLdk+KUvjpfSqkW4LP1W0oWmi
         saGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=bESFS7Lce2ivS8jPv+1Tsk70w8y9oJwx0ecowrteEFU=;
        b=Fbru+Hp6YLYIritdAREAJTikkVBCszOcwXFR7CSUakbu4CRpXZIovRl8gFcku5SBkQ
         TfH2sttq5NgF4gwEocSaBSDwFpf4E+yLkERDuto93LG+4mucaICPRnNBWuGLnR5qLDIi
         CB+sIhkPRcs9CmUDNfd4bhA3KvwHXwFWUSNfg2mH+50SkqOZr+4FnAbdBdnSdIeGkty3
         9xDOxbTdU/ENMJo0guSVJ406qF3y2KMyvELlW+KhFMnG7BignFjPwmXuSYZ9vL0O5I3h
         1kUttKT8+/wCSxJxf4ThjLCbVNTWh/RW7MjFiEIWkM32W1YAYhshUKGe86nEsw03eXSF
         URyQ==
X-Gm-Message-State: AOAM531aikG988krhOZkErIvfmuCe2Eh0k+f+ZS8zrQUIh7X8tmwPd/G
        c4Eu9iSMzH8OCxBWUKlWMZ36pQ==
X-Google-Smtp-Source: ABdhPJyM58heMRBrKl3W3F7/5YGtJ8zl5kVkB06f1nvAUR6q+OysmD95pkFrQWFB9HZo6ncqDmDnrA==
X-Received: by 2002:a17:90a:8b8f:b0:1df:14f4:b3d3 with SMTP id z15-20020a17090a8b8f00b001df14f4b3d3mr17417602pjn.163.1652789528065;
        Tue, 17 May 2022 05:12:08 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n18-20020a170903111200b0015e8d4eb25csm8986724plh.166.2022.05.17.05.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:12:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     w.bumiller@proxmox.com, linux-block@vger.kernel.org
Cc:     tj@kernel.org, Christoph Hellwig <hch@lst.de>,
        t.lamprecht@proxmox.com, cgroups@vger.kernel.org
In-Reply-To: <20220111083159.42340-1-w.bumiller@proxmox.com>
References: <20220111083159.42340-1-w.bumiller@proxmox.com>
Subject: Re: [PATCH v3] blk-cgroup: always terminate io.stat lines
Message-Id: <165278952418.12941.4325264956300231225.b4-ty@kernel.dk>
Date:   Tue, 17 May 2022 06:12:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 11 Jan 2022 09:31:59 +0100, Wolfgang Bumiller wrote:
> With the removal of seq_get_buf in blkcg_print_one_stat, we
> cannot make adding the newline conditional on there being
> relevant stats because the name was already written out
> unconditionally.
> Otherwise we may end up with multiple device names in one
> line which is confusing and doesn't follow the nested-keyed
> file format.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: always terminate io.stat lines
      commit: 3607849df47822151b05df440759e2dc70160755

Best regards,
-- 
Jens Axboe


