Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D24DC433F5
	for <linux-block@archiver.kernel.org>; Fri, 10 Dec 2021 18:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245304AbhLJS3v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Dec 2021 13:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239276AbhLJS3v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Dec 2021 13:29:51 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030BAC061746
        for <linux-block@vger.kernel.org>; Fri, 10 Dec 2021 10:26:16 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id l18so4056421pgj.9
        for <linux-block@vger.kernel.org>; Fri, 10 Dec 2021 10:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=5ZWHsHrPXRi2wsn383Uu/1pd+rYDunvKkawYraa0NUU=;
        b=z0fHip/MZwxDe4vHYomeTzwFJb3U1F6jmwmgr3rsirUf0tChAE9PzrAEZsHbsKImCf
         xS6IWdNUa3EYz58mawdCaReNw+O8oHfgl9j2dl29xc3YGvOtK99laelFIU5V9aoAVDhE
         meb/xRVCcR+yg9zzngV5tDxT2SbF1K+GThAZNbbtCkoY61bZN+rChuSGCAPN5BwME6Jm
         4WroOOpahZaNSNUxLyRsCFD/sOE+9GdNsXOc8mpZ0N+uoP+NELn+gQjbL45l7EVOQZfx
         YSZ6oHZW49PgergROwi7NGAYk8kNMMqaBiW4jKiDwnVQqrdPWjCG5Vj+XjZ6IJSIKEaN
         d07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=5ZWHsHrPXRi2wsn383Uu/1pd+rYDunvKkawYraa0NUU=;
        b=qADW0d7F1Tri/SGl5VvjtkqmDBpcxQNp3S93giOPh5X8C+c2YsNlJN/wGZ3VptNIHm
         lfh47CmzDtdKF67e/+oWTe5VOz5Arhhy1FYQXDsqyVQ1MQsyAflHGFSutIZ/SgLaDDk5
         GGTOu1dKsxETN4d7ahNrj8Un1ZTudzOlh6WXz7/+gVamq+mXXNp/DI1czaQUx23g8Ypb
         YPnQ3XQ3As1v7DmdwbIc7eocoV0A07IERpSQ7d/TDQmWiRbzyy/jD4Yt/t54/bHcIzxr
         QXVf4ItgSlBXKekGiSUCpgP7xUd+2HwWavKvX0yOKVjL6sfiiknEf9xW79QRi9mD4ej7
         JPdQ==
X-Gm-Message-State: AOAM530m8I3esgDjNU9yB6QlC61C1dnT3d2WCmaSefwWF9q01E+fIjug
        /62/rZU5wWsBJLyakELoG5XCOA==
X-Google-Smtp-Source: ABdhPJwSJasp5TOKzYWPb4Na+8MBZ6lVt9UPw0kNn5DPvNdYwiUA3S0wvCDRN19sohb737MFHivkIA==
X-Received: by 2002:a62:c541:0:b0:4ad:561a:5b6c with SMTP id j62-20020a62c541000000b004ad561a5b6cmr19546309pfg.48.1639160775461;
        Fri, 10 Dec 2021 10:26:15 -0800 (PST)
Received: from [172.20.4.26] ([66.185.175.30])
        by smtp.gmail.com with ESMTPSA id mz7sm13410388pjb.7.2021.12.10.10.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 10:26:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        oleg@redhat.com, linux-block@vger.kernel.org
In-Reply-To: <20211210182058.43417-1-dave@stgolabs.net>
References: <20211210182058.43417-1-dave@stgolabs.net>
Subject: Re: [PATCH] block: fix ioprio_get(IOPRIO_WHO_PGRP) vs setuid(2)
Message-Id: <163916077449.627295.16747606305851596098.b4-ty@kernel.dk>
Date:   Fri, 10 Dec 2021 11:26:14 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 10 Dec 2021 10:20:58 -0800, Davidlohr Bueso wrote:
> do_each_pid_thread(PIDTYPE_PGID) can race with a concurrent
> change_pid(PIDTYPE_PGID) that can move the task from one hlist
> to another while iterating. Serialize ioprio_get to take
> the tasklist_lock in this case, just like it's set counterpart.
> 
> 

Applied, thanks!

[1/1] block: fix ioprio_get(IOPRIO_WHO_PGRP) vs setuid(2)
      commit: e6a59aac8a8713f335a37d762db0dbe80e7f6d38

Best regards,
-- 
Jens Axboe


