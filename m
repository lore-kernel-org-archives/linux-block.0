Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07A5C433EF
	for <linux-block@archiver.kernel.org>; Mon, 15 Nov 2021 23:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA5C61B2C
	for <linux-block@archiver.kernel.org>; Mon, 15 Nov 2021 23:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244457AbhKOXyY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:54:24 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7700 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350275AbhKOXwK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Nov 2021 18:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637020152; x=1668556152;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8WJCuKSpYci9DBzfpgA4z0rdPlxCvpX7bhNbGO13OrA=;
  b=AKY7aIC0iLassa72p7cSoo2YCCcUgirnT697u08J+Dsu6jU7lP1Sjthp
   GeGwele584qZbk+SkkDp163Anz6EviHGc+YORlRCls3V/7s988ftXD/KO
   2M4R8ELF4cnjMNVoh0wmZalSbrjo6Fw6tODnZnXHFzb+kgy7TV1ZkoLAD
   DkmBxndOSIVgq/JkhihTnloJBCaLX34ELBT1aTg16pb11BOH1eN8JECk9
   BYeoo0dBs7eZPdXMHBRlyCWslMjf/oYBtb5vywcWjoEDYIAFJQub7x0It
   EIpHAl4foFe/W5OtRm0bjn5966dVYaHAHrrRV/6BUefD78LQmXJ72pnEZ
   A==;
X-IronPort-AV: E=Sophos;i="5.87,237,1631548800"; 
   d="scan'208";a="184673127"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2021 07:48:59 +0800
IronPort-SDR: x0caGlUQc8IlPVuoEV7A4ut+LxeoFss3HFLF8ykaiTkVpILs5mHxEk+LGdCtY4Dgh23N0U+jcp
 XeAZGV7yZklBz1InPYV0jYoiZyALYs1ZSRcAWbexLfuvIR1vyhhEw7CmOTEAA/oeqJGKQ9awYX
 6iRdyUgwsQJ44NPGrs/xZOOiqb1wHZJmY3/eRZ19KPF1mCzQqyzjoNylFd3a9kYXiPbVb7rGC1
 ec2w/5GD1QNgJwRbb+1uOaloukwIugU+Dqk6wWD6mHHzR4wO/JmNpnk/XQe7bvGZjH/wO4Kbdx
 h7fE8xvtC8kfGZvNlAmyngWK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 15:24:03 -0800
IronPort-SDR: 8fNcSF+I4KGeAPYoy3MXdADenCoZorrXBafcfajj5VMWqGFlSFfa6EG0o6UHVIeopg7L1S74jK
 NomBXrMxpwq+/RquGt/H1V76qeFXQkwvM2E0pYCvaZXD4HWCu9SIc4U0FWfFJQco8SWUUr3BNg
 oGmRpfcE9uNzcl7Z+gFDZnBhXRi1g+OY5nF1j7JycpIhts3uKbbduZfecbvewyg2frarZtxNNU
 HnqqtvbVD9IuB8iRIvM39FSH/LP+O8LqzGl9tfDG2O8Yx1oFzPjiDOj5TaqZ2si4GoUuPwqnYb
 urY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 15:49:00 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HtQrW2Cfmz1RtVm
        for <linux-block@vger.kernel.org>; Mon, 15 Nov 2021 15:48:59 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637020138; x=1639612139; bh=8WJCuKSpYci9DBzfpgA4z0rdPlxCvpX7bhN
        bGO13OrA=; b=bYTpZBUsWIpRSvJVEcXCMwDwc7oN6W3l2y3Fh/mc3SNyCnk35VR
        dmcxFJOE1wRMjuVbFlH+H6SE/kKHwyk/B5Rgq9lZBS1ColTpTtKAXWalmzk3vc7q
        PF/ZI2gd6mfJGqT55f1gnM2jntfbf7wG//dJbI5xfHFHO2bpfG6Rrt3mSsisq5GG
        XrWCQMM1hnOtMeIs1h5EnUwclRiVer3JQA2lQxTaFgtVX3fD0GHkki0ZZMYUPWmY
        NvtiJtTpH79Gg3LHPEaeCyvecSzZDH21yzxmvmhzDwhL+JLyXKa1ODM0gTNn70OQ
        iQ20ct0V4Ssq39z4i0JZKPVjRr6WS3TLwuQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3ZgzmZBOOvwO for <linux-block@vger.kernel.org>;
        Mon, 15 Nov 2021 15:48:58 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HtQrT61J4z1RtVl;
        Mon, 15 Nov 2021 15:48:57 -0800 (PST)
Message-ID: <ad266071-4b15-2090-d897-3e1b211b6291@opensource.wdc.com>
Date:   Tue, 16 Nov 2021 08:48:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH] block: Use REQ_OP_WRITE instead of its integer constant 1
 in op_is_write()
Content-Language: en-US
To:     Bean Huo <huobean@gmail.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Cc:     Bean Huo <beanhuo@micron.com>
References: <20211115215819.28787-1-huobean@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211115215819.28787-1-huobean@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/11/16 6:58, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> Use the enums REQ_OP_WRITE in op_is_write() to make it less maintenance
> requirement and more readable
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  include/linux/blk_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index fe065c394fff..5b5924a7e754 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -463,7 +463,7 @@ static inline void bio_set_op_attrs(struct bio *bio, unsigned op,
>  
>  static inline bool op_is_write(unsigned int op)
>  {
> -	return (op & 1);
> +	return (op & REQ_OP_WRITE);
>  }

See the comment for "enum req_opf":

/*
 * Operations and flags common to the bio and request structures.
 * We use 8 bits for encoding the operation, and the remaining 24 for flags.
 *
 * The least significant bit of the operation number indicates the data
 * transfer direction:
 *
 *   - if the least significant bit is set transfers are TO the device
 *   - if the least significant bit is not set transfers are FROM the device
 *
 * If a operation does not transfer data the least significant bit has no
 * meaning.
 */

So using "1" is correct. Using REQ_OP_WRITE is confusing as it seem to imply
that op_is_write() tests for "op is REQ_OP_WRITE" instead of the intended "op is
transferring data TO the device". If anything, op_is_write() could be renamed to
clarify that.

-- 
Damien Le Moal
Western Digital Research
