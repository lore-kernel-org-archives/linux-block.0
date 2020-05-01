Return-Path: <SRS0=jnOf=6P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23C3C4724C
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 13:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B089C216FD
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 13:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbgEANoq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 May 2020 09:44:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36174 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731770AbgEANop (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 May 2020 09:44:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id u15so2664127ljd.3;
        Fri, 01 May 2020 06:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fufigKI63pVyUaq3ivgITv7pbSzOzXF6p0tNBdZRj2M=;
        b=Kc14vMhsTa0Rg8ljOV1XNnvTefZ0J1Tqkg4i6kZf+k3ok4YHQuhZ2uJ0sSNFxq64AQ
         /VxODNDpaZspnv0issrQspLi2zNro8YvGqSw+RWEvFGVJRMhFnFxET24Vbl1Va7pz9Un
         oSdZfTWPv+EyXAREh0xxoPPlE4f2bSvEL63Z6opawq/ngHa9HEXwkxK7ELN6lnoH+iib
         vaEeqxooV8MRkYeiAz26tHhkjusem03q22gvCNvnTtYl4b9FhLTFoZWErIFd0iAO6S/v
         BAgeoSfa4WfPZU4/MiYnDUNMHYVH9IXZ9QscwurH42k035l8Nl9wyrjo9b24DU2zqV17
         Y9Vw==
X-Gm-Message-State: AGi0PuYAcCnhcEumIY7wE3UYR6jER8sRfckqnDTHgxWRvjrZOmGW8sS0
        Y3H+vTcHT8Y4FhwXhqb9MeKr61XOAOA=
X-Google-Smtp-Source: APiQypLo9C82ia9SxfYVZ0sEooi2E7ScJlipjbSBikdjMFaputKL+PfdMhPwCiTxqEMNHBS7o4alKQ==
X-Received: by 2002:a2e:a37b:: with SMTP id i27mr2363790ljn.36.1588340682811;
        Fri, 01 May 2020 06:44:42 -0700 (PDT)
Received: from localhost.localdomain ([213.87.150.177])
        by smtp.googlemail.com with ESMTPSA id b2sm2269194lfi.14.2020.05.01.06.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 06:44:42 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, Willy Tarreau <w@1wt.eu>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] floppy: suppress UBSAN warning in setup_rw_floppy()
Date:   Fri,  1 May 2020 16:44:12 +0300
Message-Id: <20200501134416.72248-1-efremov@linux.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These patches are based on Willy's cleanup patches
https://lkml.org/lkml/2020/3/31/609.

The first patch removes pr_cont() in setup_DMA() and prints the contents of
cmd buffer with print_hex_dump(). The last patch also touches these lines
and changes cmd buffer to fullcmd. The 2,3 patches introduce defines to
make it more clear why cmd_count in struct floppy_raw_cmd allows
out-of-bounds access for cmd, reply_count, reply fields. Last patch
handles the warning.

There is the checkpatch warning because of the line length 81 > 80 in
the definition of valid_floppy_drive_params(). This function
intentionally uses autodetect[8] as argument to highlight that this
is exactly the autodetect field from structs floppy_drive_params and
compat_floppy_drive_params. I think that this warning is not a big
problem since next function definition is 85 chars long and whole
driver requires "restyling".

Changes in v3:
 - fix indentation in the second patch
 - remove FD_RAW_REPLY_SIZE from print_hex_dump() in the third patch

Changes in v2:
 - add FD_RAW_CMD_FULLSIZE to the second patch
 - add union with fullcmd to struct floppy_raw_cmd in the last patch

Denis Efremov (4):
  floppy: use print_hex_dump() in setup_DMA()
  floppy: add FD_AUTODETECT_SIZE define for struct floppy_drive_params
  floppy: add defines for sizes of cmd & reply buffers of floppy_raw_cmd
  floppy: suppress UBSAN warning in setup_rw_floppy()

 drivers/block/floppy.c  | 39 ++++++++++++++-------------------------
 include/uapi/linux/fd.h | 26 ++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 29 deletions(-)

-- 
2.25.3

