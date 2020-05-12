Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF83CA90AF
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 17:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120AC206B8
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 17:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgELRd4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 13:33:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35798 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgELRd4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 13:33:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id x73so11277240lfa.2;
        Tue, 12 May 2020 10:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7PJDYyaeHhNlAcvExPRKc/7NtIMxIppOaGSnAUjpGxA=;
        b=DPpezT44nisGGLnZ2r48DINfRf0LnKtHPEUXSNjA/xKPNkZFp5CiusCWmnVgxGEQHz
         1mxLqLtWZizOayaMmvTHtxTK5pxbtRVtFO/QP77b5W8LdQKaKF91672giIDBLpzweze6
         TqtFmlWcOaCYC/3xlFbZi4Ne8/gtqRXU8txWulxEqOrFGfKgbaeaq9oblEwbAQvlczoD
         9PVyrzABlvVb7UD/ME0MeS2iK2M8yj09YCWUvi4ZWGCxG2KGkjVQHQqMsGSNGxxVA7Ja
         SsPF12w35c/R1WOEToCk9TBJWCVRSaXpntpl/cJPB6EiJzZScPPNnVyAQIhzShxEe4S5
         mrzg==
X-Gm-Message-State: AOAM532jaiLCkN2XlPMEOnkKV619BANNOYLt8hvvRqhG5oLJ8VTxfKH5
        uxKrXIfKNPn5rdBbnyQHw8E0OPY7+i0=
X-Google-Smtp-Source: ABdhPJx4fv1v087d7w7IXnltOlzwy2GrIgjHxia3EJpn0ouCyDBjgLs94ab9z0INoYjWULQO89Ngrw==
X-Received: by 2002:ac2:5e24:: with SMTP id o4mr14990828lfg.37.1589304832726;
        Tue, 12 May 2020 10:33:52 -0700 (PDT)
Received: from [192.168.1.8] ([213.87.130.150])
        by smtp.gmail.com with ESMTPSA id t13sm13355480ljd.38.2020.05.12.10.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 10:33:52 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <8d8cb63b-e1ff-ddef-a6e9-8f7adb21be60@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 mQINBFsJUXwBEADDnzbOGE/X5ZdHqpK/kNmR7AY39b/rR+2Wm/VbQHV+jpGk8ZL07iOWnVe1
 ZInSp3Ze+scB4ZK+y48z0YDvKUU3L85Nb31UASB2bgWIV+8tmW4kV8a2PosqIc4wp4/Qa2A/
 Ip6q+bWurxOOjyJkfzt51p6Th4FTUsuoxINKRMjHrs/0y5oEc7Wt/1qk2ljmnSocg3fMxo8+
 y6IxmXt5tYvt+FfBqx/1XwXuOSd0WOku+/jscYmBPwyrLdk/pMSnnld6a2Fp1zxWIKz+4VJm
 QEIlCTe5SO3h5sozpXeWS916VwwCuf8oov6706yC4MlmAqsQpBdoihQEA7zgh+pk10sCvviX
 FYM4gIcoMkKRex/NSqmeh3VmvQunEv6P+hNMKnIlZ2eJGQpz/ezwqNtV/przO95FSMOQxvQY
 11TbyNxudW4FBx6K3fzKjw5dY2PrAUGfHbpI3wtVUNxSjcE6iaJHWUA+8R6FLnTXyEObRzTS
 fAjfiqcta+iLPdGGkYtmW1muy/v0juldH9uLfD9OfYODsWia2Ve79RB9cHSgRv4nZcGhQmP2
 wFpLqskh+qlibhAAqT3RQLRsGabiTjzUkdzO1gaNlwufwqMXjZNkLYu1KpTNUegx3MNEi2p9
 CmmDxWMBSMFofgrcy8PJ0jUnn9vWmtn3gz10FgTgqC7B3UvARQARAQABtCFEZW5pcyBFZnJl
 bW92IDxlZnJlbW92QGxpbnV4LmNvbT6JAlcEEwEIAEECGwMFCQPCZwAFCwkIBwIGFQoJCAsC
 BBYCAwECHgECF4AWIQR2VAM2ApQN8ZIP5AO1IpWwM1AwHwUCW3qdrQIZAQAKCRC1IpWwM1Aw
 HwF5D/sHp+jswevGj304qvG4vNnbZDr1H8VYlsDUt+Eygwdg9eAVSVZ8yr9CAu9xONr4Ilr1
 I1vZRCutdGl5sneXr3JBOJRoyH145ExDzQtHDjqJdoRHyI/QTY2l2YPqH/QY1hsLJr/GKuRi
 oqUJQoHhdvz/NitR4DciKl5HTQPbDYOpVfl46i0CNvDUsWX7GjMwFwLD77E+wfSeOyXpFc2b
 tlC9sVUKtkug1nAONEnP41BKZwJ/2D6z5bdVeLfykOAmHoqWitCiXgRPUg4Vzc/ysgK+uKQ8
 /S1RuUA83KnXp7z2JNJ6FEcivsbTZd7Ix6XZb9CwnuwiKDzNjffv5dmiM+m5RaUmLVVNgVCW
 wKQYeTVAspfdwJ5j2gICY+UshALCfRVBWlnGH7iZOfmiErnwcDL0hLEDlajvrnzWPM9953i6
 fF3+nr7Lol/behhdY8QdLLErckZBzh+tr0RMl5XKNoB/kEQZPUHK25b140NTSeuYGVxAZg3g
 4hobxbOGkzOtnA9gZVjEWxteLNuQ6rmxrvrQDTcLTLEjlTQvQ0uVK4ZeDxWxpECaU7T67khA
 ja2B8VusTTbvxlNYbLpGxYQmMFIUF5WBfc76ipedPYKJ+itCfZGeNWxjOzEld4/v2BTS0o02
 0iMx7FeQdG0fSzgoIVUFj6durkgch+N5P1G9oU+H37kCDQRbCVF8ARAA3ITFo8OvvzQJT2cY
 nPR718Npm+UL6uckm0Jr0IAFdstRZ3ZLW/R9e24nfF3A8Qga3VxJdhdEOzZKBbl1nadZ9kKU
 nq87te0eBJu+EbcuMv6+njT4CBdwCzJnBZ7ApFpvM8CxIUyFAvaz4EZZxkfEpxaPAivR1Sa2
 2x7OMWH/78laB6KsPgwxV7fir45VjQEyJZ5ac5ydG9xndFmb76upD7HhV7fnygwf/uIPOzNZ
 YVElGVnqTBqisFRWg9w3Bqvqb/W6prJsoh7F0/THzCzp6PwbAnXDedN388RIuHtXJ+wTsPA0
 oL0H4jQ+4XuAWvghD/+RXJI5wcsAHx7QkDcbTddrhhGdGcd06qbXe2hNVgdCtaoAgpCEetW8
 /a8H+lEBBD4/iD2La39sfE+dt100cKgUP9MukDvOF2fT6GimdQ8TeEd1+RjYyG9SEJpVIxj6
 H3CyGjFwtIwodfediU/ygmYfKXJIDmVpVQi598apSoWYT/ltv+NXTALjyNIVvh5cLRz8YxoF
 sFI2VpZ5PMrr1qo+DB1AbH00b0l2W7HGetSH8gcgpc7q3kCObmDSa3aTGTkawNHzbceEJrL6
 mRD6GbjU4GPD06/dTRIhQatKgE4ekv5wnxBK6v9CVKViqpn7vIxiTI9/VtTKndzdnKE6C72+
 jTwSYVa1vMxJABtOSg8AEQEAAYkCPAQYAQgAJhYhBHZUAzYClA3xkg/kA7UilbAzUDAfBQJb
 CVF8AhsMBQkDwmcAAAoJELUilbAzUDAfB8cQALnqSjpnPtFiWGfxPeq4nkfCN8QEAjb0Rg+a
 3fy1LiquAn003DyC92qphcGkCLN75YcaGlp33M/HrjrK1cttr7biJelb5FncRSUZqbbm0Ymj
 U4AKyfNrYaPz7vHJuijRNUZR2mntwiKotgLV95yL0dPyZxvOPPnbjF0cCtHfdKhXIt7Syzjb
 M8k2fmSF0FM+89/hP11aRrs6+qMHSd/s3N3j0hR2Uxsski8q6x+LxU1aHS0FFkSl0m8SiazA
 Gd1zy4pXC2HhCHstF24Nu5iVLPRwlxFS/+o3nB1ZWTwu8I6s2ZF5TAgBfEONV5MIYH3fOb5+
 r/HYPye7puSmQ2LCXy7X5IIsnAoxSrcFYq9nGfHNcXhm5x6WjYC0Kz8l4lfwWo8PIpZ8x57v
 gTH1PI5R4WdRQijLxLCW/AaiuoEYuOLAoW481XtZb0GRRe+Tm9z/fCbkEveyPiDK7oZahBM7
 QdWEEV8mqJoOZ3xxqMlJrxKM9SDF+auB4zWGz5jGzCDAx/0qMUrVn2+v8i4oEKW6IUdV7axW
 Nk9a+EF5JSTbfv0JBYeSHK3WRklSYLdsMRhaCKhSbwo8Xgn/m6a92fKd3NnObvRe76iIEMSw
 60iagNE6AFFzuF/GvoIHb2oDUIX4z+/D0TBWH9ADNptmuE+LZnlPUAAEzRgUFtlN5LtJP8ph
Subject: [GIT PULL RESEND] Floppy cleanups for next
Message-ID: <565fc2e1-a790-241f-7a98-52a4c5ff8158@linux.com>
Date:   Tue, 12 May 2020 20:33:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8d8cb63b-e1ff-ddef-a6e9-8f7adb21be60@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Rebased on for-5.8/drivers branch.

The following changes since commit 92decf118f1da4c866515f80387f9cf4d48611d6:

  nvme: define constants for identification values (2020-05-09 16:18:36 -0600)

are available in the Git repository at:

  https://github.com/evdenis/linux-floppy tags/floppy-for-5.8

for you to fetch changes up to 0836275df4db20daf040fff5d9a1da89c4c08a85:

  floppy: suppress UBSAN warning in setup_rw_floppy() (2020-05-12 19:34:57 +0300)

----------------------------------------------------------------
Floppy patches for 5.8

Cleanups:
  - symbolic register names for x86,sparc64,sparc32,powerpc,parisc,m68k
  - split of local/global variables for drive,fdc
  - UBSAN warning suppress in setup_rw_floppy()

Changes were compile tested on arm, sparc64, powerpc, m68k. Many patches
introduce no binary changes by using defines instead of magic numbers.
The patches were also tested with syzkaller and simple write/read/format
tests on real hardware.

Signed-off-by: Denis Efremov <efremov@linux.com>

----------------------------------------------------------------
Denis Efremov (4):
      floppy: use print_hex_dump() in setup_DMA()
      floppy: add FD_AUTODETECT_SIZE define for struct floppy_drive_params
      floppy: add defines for sizes of cmd & reply buffers of floppy_raw_cmd
      floppy: suppress UBSAN warning in setup_rw_floppy()

Willy Tarreau (27):
      floppy: split the base port from the register in I/O accesses
      floppy: add references to 82077's extra registers
      floppy: use symbolic register names in the m68k port
      floppy: use symbolic register names in the parisc port
      floppy: use symbolic register names in the powerpc port
      floppy: use symbolic register names in the sparc32 port
      floppy: use symbolic register names in the sparc64 port
      floppy: use symbolic register names in the x86 port
      floppy: cleanup: make twaddle() not rely on current_{fdc,drive} anymore
      floppy: cleanup: make reset_fdc_info() not rely on current_fdc anymore
      floppy: cleanup: make show_floppy() not rely on current_fdc anymore
      floppy: cleanup: make wait_til_ready() not rely on current_fdc anymore
      floppy: cleanup: make output_byte() not rely on current_fdc anymore
      floppy: cleanup: make result() not rely on current_fdc anymore
      floppy: cleanup: make need_more_output() not rely on current_fdc anymore
      floppy: cleanup: make perpendicular_mode() not rely on current_fdc anymore
      floppy: cleanup: make fdc_configure() not rely on current_fdc anymore
      floppy: cleanup: make fdc_specify() not rely on current_{fdc,drive} anymore
      floppy: cleanup: make check_wp() not rely on current_{fdc,drive} anymore
      floppy: cleanup: make next_valid_format() not rely on current_drive anymore
      floppy: cleanup: make get_fdc_version() not rely on current_fdc anymore
      floppy: cleanup: do not iterate on current_fdc in DMA grab/release functions
      floppy: cleanup: add a few comments about expectations in certain functions
      floppy: cleanup: do not iterate on current_fdc in do_floppy_init()
      floppy: make sure to reset all FDCs upon resume()
      floppy: cleanup: get rid of current_reqD in favor of current_drive
      floppy: cleanup: make set_fdc() always set current_drive and current_fd

 arch/alpha/include/asm/floppy.h             |   4 +-
 arch/arm/include/asm/floppy.h               |   8 +-
 arch/m68k/include/asm/floppy.h              |  27 ++++---
 arch/mips/include/asm/mach-generic/floppy.h |   8 +-
 arch/mips/include/asm/mach-jazz/floppy.h    |   8 +-
 arch/parisc/include/asm/floppy.h            |  19 ++---
 arch/powerpc/include/asm/floppy.h           |  19 ++---
 arch/sparc/include/asm/floppy_32.h          |  50 ++++++------
 arch/sparc/include/asm/floppy_64.h          |  59 +++++++-------
 arch/x86/include/asm/floppy.h               |  19 ++---
 drivers/block/floppy.c                      | 456 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------
 include/uapi/linux/fd.h                     |  26 +++++-
 include/uapi/linux/fdreg.h                  |  16 +++-
 13 files changed, 384 insertions(+), 335 deletions(-)
