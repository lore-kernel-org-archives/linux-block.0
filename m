Return-Path: <SRS0=UGhi=5B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B291C0044D
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0626C20724
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbgCPKrQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:47:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46645 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730478AbgCPKrQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Mar 2020 06:47:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id w16so4121113wrv.13;
        Mon, 16 Mar 2020 03:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:from:subject:to:cc:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=vibrpsfD5nBtWhWdlH3ux6m1+gQfms/bPDCbvYSFzpo=;
        b=edUqCDWd5hANKotdVUU0tGSWv+oTEeXqrS8e1dZf78UMP6YSX+Qrc92jmvxYMq7BCF
         kWmeUKT4LENlzODB+Kzs66GS1vWpNByu4/fkdovwBQr1RQoNY8UVGNSgVDDr3cJ+ajXt
         AYWD2/bEQo8Pw+sMEHUf3+v0VbIqnUB6RdoNhuYId3GDlzcKUIXMOaGCN2D8jtgf9+rL
         kT16hcuaf8qW9hxQO8Aya89Z4RKwoNLIt+a0BM6/9l+Id9jOqJVLgpbDiHxlniGEhvK6
         SBjZouuAEFUFM7r3krUs06SYcSsWXSz3ODb1molnNFCJr/1CuAn2OuHhy2FXn7K5IfTI
         pktA==
X-Gm-Message-State: ANhLgQ3t0EM6VxbSRReJoxkVEYkkd7rleeXSQJ+5YDtkzTWO8skk8Bv4
        JeZKAatCaWeHyWqBshE4PdVHceXY
X-Google-Smtp-Source: ADFU+vtfqmhyM8ZGOur535mw2J65SLHFV+3Dyr1SkDMRkjVA7DD0D2EXtkp/u/lK5t9hze4MfQnGzQ==
X-Received: by 2002:a5d:5586:: with SMTP id i6mr35833352wrv.338.1584355634281;
        Mon, 16 Mar 2020 03:47:14 -0700 (PDT)
Received: from [10.10.2.174] (winnie.ispras.ru. [83.149.199.91])
        by smtp.gmail.com with ESMTPSA id f11sm5988514wrq.88.2020.03.16.03.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 03:47:13 -0700 (PDT)
Reply-To: efremov@linux.com
From:   Denis Efremov <efremov@linux.com>
Subject: [GIT PULL] Floppy cleanups for next
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
Message-ID: <57ce0ee0-839c-a889-0bc0-ec46985e76d3@linux.com>
Date:   Mon, 16 Mar 2020 13:47:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The following changes since commit 5d50c8f405bf91d9d9a48628fde0f2f4ff069d7b:

  Merge branch 'for-5.7/io_uring' into for-next (2020-03-14 17:20:45 -0600)

are available in the Git repository at:

  https://github.com/evdenis/linux-floppy tags/floppy-for-5.7

Please pull

----------------------------------------------------------------
Floppy patches for 5.7

Cleanups from Willy Tarreau:
  - expansion of macros referencing global or local variables with
    equivalent code
  - removal of incomplete support for second FDC from ARM code
  - renaming the "fdc" global variable to "current_fdc" to differ
    between global and local context

Changes were compile tested on arm, x86 arches. Changes introduce
no binary difference on x86 arch (before and after the patches).
On arm, incomplete support for second FDC removed. This set of
patches with commit 2e90ca68 ("floppy: check FDC index for errors
before assigning it") was tested with syzkaller and simple
write/read/format tests for no new issues.

Signed-off-by: Denis Efremov <efremov@linux.com>

----------------------------------------------------------------
Willy Tarreau (16):
      floppy: cleanup: expand macro FDCS
      floppy: cleanup: expand macro UFDCS
      floppy: cleanup: expand macro UDP
      floppy: cleanup: expand macro UDRS
      floppy: cleanup: expand macro UDRWE
      floppy: cleanup: expand macro DP
      floppy: cleanup: expand macro DRS
      floppy: cleanup: expand macro DRWE
      floppy: cleanup: expand the R/W / format command macros
      floppy: cleanup: expand the reply_buffer macros
      floppy: remove dead code for drives scanning on ARM
      floppy: remove incomplete support for second FDC from ARM code
      floppy: prepare ARM code to simplify base address separation
      floppy: introduce new functions fdc_inb() and fdc_outb()
      floppy: separate the FDC's base address from its registers
      floppy: rename the global "fdc" variable to "current_fdc"

 arch/arm/include/asm/floppy.h |   88 +----
 drivers/block/floppy.c        | 1093 +++++++++++++++++++++++++++++++----------------------------
 include/uapi/linux/fdreg.h    |   18 +-
 3 files changed, 586 insertions(+), 613 deletions(-)
