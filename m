Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA42C28D13
	for <linux-block@archiver.kernel.org>; Mon, 22 Aug 2022 21:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbiHVVMr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 17:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbiHVVMo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 17:12:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA5952839;
        Mon, 22 Aug 2022 14:12:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so12636992pjf.2;
        Mon, 22 Aug 2022 14:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=Qqhe4dGTXI0LJAzpRWcBaxc07OdXWSOgcInlZlsxK5Q=;
        b=KSF4PMenZoPIitoMl71A7HkBX7U6tXwdDeE94jUJc0ddPiNcMfS8avusFBLEOYBxuE
         hJG2TMzAfAaoN0C5XWVh627toC/1dkzLhVhEy8o3w4+aSU53BOKO7W4ry0qPfAgxD6gW
         B9yl9H61tOFLxeve1k0gifsmkQ6fqxUeXX5Gj5qBegZSCqdFFpWV43MAFbBIR4NG08Mi
         MIU0Qps2o1VafP7TIXV0j5wTpVs4VmzLme456cwF6Cpikb0z4xxCWR7wqcE5yCL+/nag
         v6TQSVjizjUPaYHLNj28LOavUeDQgm42RO8hVtXsS9F+427VBMiUIhhufauEMyfTaIyt
         bCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Qqhe4dGTXI0LJAzpRWcBaxc07OdXWSOgcInlZlsxK5Q=;
        b=duis++ibVM9RvsPu9nX9NjJQ/TWzi3GhDE8WXr+v9jsj1E64vAVw3JGqj9j1lv9V6m
         uG52Y41jz27noZ/SnDBtwBuYSpcOy3opOKtt96UI3sIT/htOk6wG5jhYooI5lRkZM/3S
         QAuu+pdriO+X3ZLeKSKnwYfSy/eyhjW0/7Couh+p/kv5UhUtYqL5orxi7i8nSMJdEJN7
         va/8SptV/9rzWdKcA6lZFWwzuwhrZgFSw5oPnzzNqgQXR8t6NW93KNnOo5l7HcLaVS5i
         TimAFm9ftbUve4hV/Fj8DTdxqaTw7SyXleI697uabh7GuYl/LZQK4AeFd7hd7BcjL89m
         5kGA==
X-Gm-Message-State: ACgBeo12tKdjqZLjB0DhutIp7j4o3HN+6LGAqotlIj5AmKm2id+ikvgz
        iPACAXDe5FD5kwpJomUfehQ=
X-Google-Smtp-Source: AA6agR504BPg0N5bsYIJP15IrGpzIOT82zeZG4MOBibfM5cyez+Dq540lAomfgUDosmJ5BGhLmcNPw==
X-Received: by 2002:a17:902:e5cc:b0:16f:1e31:da6c with SMTP id u12-20020a170902e5cc00b0016f1e31da6cmr21792721plf.66.1661202762628;
        Mon, 22 Aug 2022 14:12:42 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
        by smtp.gmail.com with ESMTPSA id f14-20020a65590e000000b00422c003cf78sm7831920pgu.82.2022.08.22.14.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:12:42 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 289F136031A; Tue, 23 Aug 2022 09:12:39 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de
Subject: [PATCH v9 0/2 RESEND #2] Amiga RDB partition support fixes
Date:   Tue, 23 Aug 2022 09:12:34 +1200
Message-Id: <20220822211236.9023-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The simple fix still leaves ample room for overflows in calculating start
address and size of a RDB partition, though such overflows should only be 
seen in rather unusual cases. To address these potential overflows, checks
are added in the second patch of this series. Comments by Geert have been   
addressed in full. 

Reviewed-by tags by Geert and Christoph added. Fixes and prerequisites
for stable backport added. 

Cheers,

        Michael



