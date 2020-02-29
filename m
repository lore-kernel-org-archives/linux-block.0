Return-Path: <SRS0=t5dV=4R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6886EC3F2C6
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 16:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367AA20866
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 16:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgB2QjC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Feb 2020 11:39:02 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40942 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbgB2QjC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Feb 2020 11:39:02 -0500
Received: by mail-lj1-f195.google.com with SMTP id 143so6836313ljj.7;
        Sat, 29 Feb 2020 08:39:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=p/EJnUXjKK9tSG671VjWXjth9Z02XftSAg9w+XBqvv4=;
        b=nTg53mvGV9xu7jQvAUd8wTlUspQWJI+qHEBUb+iEDHCVnmflm4xbn/G2WKNOfg2+3p
         U/UBT/mb4yAytkY2dgZpzLU1jfFd9JWDp8NRyVE3WWRVivQuazBSPIQFGdcDmO1XFGPJ
         HlR7Lq1fiAHv4GByoxf9Q5U/Cv8TMk5pG5REcCIhlhaKffB4FG6Pg/ZTw4VOvjMyJBy/
         xo7D5NssD5tctLJ6MVqP3wrGUT30mGmbxdNptx4BegiXdlKnQLyg1AxESqtud8OM92s4
         4P5xclJc4u4ZEX5yNz+3ige/lNpb0Qtn14YoebOwZzZ9we3NXcVox3DVKBGtD/teiY8c
         5+QA==
X-Gm-Message-State: ANhLgQ3kvVxVW4rTWv+j1c1HCTstK2Ay+8EntiKkrmaJwzz2DuwUtDqH
        vAqR4N0M3FPzya/5Q+ie7JmisrC3
X-Google-Smtp-Source: ADFU+vu916QxtadFDu/uNc0ia7G4UFr7VdQm1jCz/Bso/ErgTlLNSp28DqJb8izvr3p5fx/XBTksmQ==
X-Received: by 2002:a2e:9a0e:: with SMTP id o14mr2818777lji.63.1582994339307;
        Sat, 29 Feb 2020 08:38:59 -0800 (PST)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id 19sm7287556lfp.86.2020.02.29.08.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 08:38:58 -0800 (PST)
To:     Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200224212352.8640-1-w@1wt.eu> <20200226080732.1913-1-w@1wt.eu>
 <20200226080732.1913-2-w@1wt.eu>
From:   Denis Efremov <efremov@linux.com>
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
Subject: Re: [PATCH 12/16] floppy: remove incomplete support for second FDC
 from ARM code
Message-ID: <5a753f4c-5e30-ccf9-ab26-a3a1a1d7ff4c@linux.com>
Date:   Sat, 29 Feb 2020 19:38:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200226080732.1913-2-w@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2/26/20 11:07 AM, Willy Tarreau wrote:
> The ARM code was written with the apparent hope to one day support
> a second FDC except that the code was incomplete and only touches
> the first one, which is also reflected by N_FDC==1. However this
> made its fd_outb() macro artificially depend on the global or local
> "fdc" variable.
> 
> Let's get rid of this and make it explicit it doesn't rely on this
> variable anymore.
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  arch/arm/include/asm/floppy.h | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/include/asm/floppy.h b/arch/arm/include/asm/floppy.h
> index 4655652..f683953 100644
> --- a/arch/arm/include/asm/floppy.h
> +++ b/arch/arm/include/asm/floppy.h
> @@ -50,17 +50,16 @@ static inline int fd_dma_setup(void *data, unsigned int length,
>   * to a non-zero track, and then restoring it to track 0.  If an error occurs,
>   * then there is no floppy drive present.       [to be put back in again]
>   */
> -static unsigned char floppy_selects[2][4] =
> +static unsigned char floppy_selects[4] =
>  {
>  	{ 0x10, 0x21, 0x23, 0x33 },
> -	{ 0x10, 0x21, 0x23, 0x33 }
>  };
>  

You need remove curly braces here, e.g.
static unsigned char floppy_selects[4] =
{
	0x10, 0x21, 0x23, 0x33
};

>  #define fd_setdor(dor)								\
>  do {										\
>  	int new_dor = (dor);							\
>  	if (new_dor & 0xf0)							\
> -		new_dor = (new_dor & 0x0c) | floppy_selects[fdc][new_dor & 3];	\
> +		new_dor = (new_dor & 0x0c) | floppy_selects[new_dor & 3];	\
>  	else									\
>  		new_dor &= 0x0c;						\
>  	outb(new_dor, FD_DOR);							\
> @@ -84,9 +83,9 @@ do {										\
>   */
>  static void driveswap(int *ints, int dummy, int dummy2)
>  {
> -	floppy_selects[0][0] ^= floppy_selects[0][1];
> -	floppy_selects[0][1] ^= floppy_selects[0][0];
> -	floppy_selects[0][0] ^= floppy_selects[0][1];
> +	floppy_selects[0] ^= floppy_selects[1];
> +	floppy_selects[1] ^= floppy_selects[0];
> +	floppy_selects[0] ^= floppy_selects[1];

What do you think about using swap macro (kernel.h) here?

>  }
>  
>  #define EXTRA_FLOPPY_PARAMS ,{ "driveswap", &driveswap, NULL, 0, 0 }
> 

Denis
