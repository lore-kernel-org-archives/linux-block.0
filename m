Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:23381 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940845AbdDTCok (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2017 22:44:40 -0400
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 6/9] T10: Move opencoded contants to common header
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
        <1491332201-26926-7-git-send-email-dmonakhov@openvz.org>
Date: Wed, 19 Apr 2017 22:44:31 -0400
In-Reply-To: <1491332201-26926-7-git-send-email-dmonakhov@openvz.org> (Dmitry
        Monakhov's message of "Tue, 4 Apr 2017 22:56:38 +0400")
Message-ID: <yq14lxjpzlc.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Dmitry Monakhov <dmonakhov@openvz.org> writes:

Dmitry,

> diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
> index 9fba9dd..f892442 100644
> --- a/include/linux/t10-pi.h
> +++ b/include/linux/t10-pi.h
> @@ -33,6 +33,8 @@ struct t10_pi_tuple {
>  	__be32 ref_tag;		/* Target LBA or indirect LBA */
>  };
>  
> +#define T10_APP_ESCAPE cpu_to_be16(0xffff)
> +#define T10_REF_ESCAPE cpu_to_be32(0xffffffff)

T10 just means SCSI and does not imply protection information. Please
make these T10_PI_{REF,APP}_ESCAPE (ideally in an enum).

-- 
Martin K. Petersen	Oracle Linux Engineering
