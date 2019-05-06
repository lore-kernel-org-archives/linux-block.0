Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B358C04A6B
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 20:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DB72087F
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 20:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="0Ol2v+34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfEFUCR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 16:02:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40672 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfEFUCQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 16:02:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id d31so6994979pgl.7
        for <linux-block@vger.kernel.org>; Mon, 06 May 2019 13:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zwFJMeH+465vPDesA0cG3Zx8X8eiU2G2Zdp2IRfouCg=;
        b=0Ol2v+34tOxYo/t7wVKZ5uKhPz1O+boer40LSs36idNkmCuqmdvZN340Boy8CJnCbq
         ChhrgK4d6e93bEyDuWuO6MdOiDwGwEQksPJbzj3JmxKfxTlXGcc6ZivCtwqzwNREAO++
         AUuEqdNqQvdTCMZnVbcgDeROQOtqPJ9l0KcB/rlB9Pd4oDXrphrsRKlwwhsDSQjLeSJw
         1/5X7VUiPPTBmB16sjc2huwYJ0WCzjK88vFv3lcPlTyX/4ONzGXdsNPggwL2ai7tZq+V
         FOcS6qkycwheQJs1EaL6RZnA6iNv4efKnDMUezH4CdsLyRztMNBFMHKauhZes7SwuY6D
         Taig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zwFJMeH+465vPDesA0cG3Zx8X8eiU2G2Zdp2IRfouCg=;
        b=RneQZuepXjF3YQNXZJlzkRS2CeUN/G5F3NqqWHneOP5PItxTT8Kbu0F3UJ6gX+W0hl
         eEPuMoV2TfMjUZfswY2ZYSpoEQLXCCs4qJxpWzYt2AhDzBvR5WT6NLbk9Or6Ns4lEDxI
         bir/wIeyWWYZG1CsXwxY/kYAhCQGf9ozCpXRy01vT4tYAA4mveMziWDCLc/v+NgbxN3u
         69GDrOZKmDMAsDnG9lD5BdvlXBpkFiY1Gb1U9JbXH5KlFltHZeW1GKetgpDVnR2oMVsY
         +RakW4PK4YQBsgSIG/voUbjGJeJDoDZQdnprBLC372FGevemMLQEcfBRP2ZtIxCJySA+
         ZMlA==
X-Gm-Message-State: APjAAAWSzVouuum0mERR0+U6AOZxBsnqkrhqXVW1ttHirHpmi4cXe4KY
        rBULSmpbPOL0Kx1GTIZlMsVcfA==
X-Google-Smtp-Source: APXvYqyGtFJObMZfWZrG4jniaZan/1965GjZOa/GGD7ju1ObzR7/bhbluZYLefMJStXdupvWM+WX8A==
X-Received: by 2002:aa7:8b88:: with SMTP id r8mr35590202pfd.174.1557172935544;
        Mon, 06 May 2019 13:02:15 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:cf4])
        by smtp.gmail.com with ESMTPSA id d5sm19901032pgb.33.2019.05.06.13.02.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 13:02:14 -0700 (PDT)
Date:   Mon, 6 May 2019 13:02:13 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block/028: check if T10 verification fails
Message-ID: <20190506200213.GD20450@vader>
References: <20190426023937.19584-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426023937.19584-1-ming.lei@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 26, 2019 at 10:39:37AM +0800, Ming Lei wrote:
> When T10 verification fails, the error code of BLK_STS_PROTECTION
> may not be propagated to user space, see mpage_end_io().
> 
> So seems the only reliable way for detecting the failure is to
> check dmesg.
> 
> Cc: Martin K . Petersen <martin.petersen@oracle.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tests/block/028 | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tests/block/028 b/tests/block/028
> index 7bee691c0515..a0ab9ff208db 100755
> --- a/tests/block/028
> +++ b/tests/block/028
> @@ -38,6 +38,14 @@ test() {
>  			test_pi "$dix" "$dif"
>  			echo "Test(dix:$dix dif:$dif) complete"
>  		done
> +		if dmesg | grep -q "guard tag error at sector"; then
> +			echo "Fail"
> +			break
> +		fi
> +		if dmesg | grep -q "ref tag error at location"; then
> +			echo "Fail"
> +			break
> +		fi

This will also catch messages that didn't occur during the test run. Not
a huge deal, but I reworked it to use DMESG_FILTER instead. Thanks!
