Return-Path: <SRS0=U2g7=XK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450FCC4CEC7
	for <linux-block@archiver.kernel.org>; Sun, 15 Sep 2019 16:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E917214DA
	for <linux-block@archiver.kernel.org>; Sun, 15 Sep 2019 16:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YK4p2eFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfIOQxL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Sep 2019 12:53:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46229 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfIOQxK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Sep 2019 12:53:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id i8so30976097edn.13
        for <linux-block@vger.kernel.org>; Sun, 15 Sep 2019 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=NE62AvYwr2fHN9O7VfK9OZZ/0kWwNLe+LnJGHGoUr1Y=;
        b=YK4p2eFMYPmu7Bwf0ssYr5v7xvHTnr220kk9ynwpS5vFkpQ1CyAIN4e3EKcjadtswb
         5Gqo8fGps25x9b8E6Z8z/qjmyB8Gex0hi/AfD5MPmAKXFsuvEjKrgUVsluWkN/ih5Z8a
         K6grJ0cbbtEeeLgK5si31exe7ndUPy4kpdiUfjbR4FD64xCAH0pW/E+hn2UByE92eYjr
         /kCBi+HAiyg4OaeMuAMhlhG8eT5/nGcIhesO98ETeYi3BgwIY5HKrB5Db1mgAbs62AxO
         kSjbJ+ARkvG1Z6NE250k4VaaY9Kdo/yEh6+p7n8fJz9kE4pmNDmRPRuD+QNW0b6HtUhe
         2/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=NE62AvYwr2fHN9O7VfK9OZZ/0kWwNLe+LnJGHGoUr1Y=;
        b=hjIPNCF8AhbkckjxUbLzC99FCcc8OKoLn31zIYD0JhGSOv7VEWPfGvbBSG5Ku3LEq5
         RmoIUhYLBlt2bOuvqAXZSQiiMByADP2Mi1FF34QVxHgZBSmJkEInxVcdIUbMepB7CNVf
         TSjfS74QABeHDtk9vrpb5yRhjqTLlLIei/1D8r+OSYSF3ZJ4XM9lCoS25Vu0PHcvw2wR
         LpueBobH1SParhC4DRVvB+dJUwBy79a/BbFcu8b0M7JPJYL0zlijwfchZKLdHiuIpKru
         rv1wRsxKW3odCM8ZBTscRgMij1r09JEanF+GJU1DkIKGiJx63PoklZFCbydfMfzV24EV
         IHrA==
X-Gm-Message-State: APjAAAUV6hAa3FaXVEUwCnTd1eCpaYNBiBAxyntkPyngHw8ttu80CBFS
        Poax17ePlHix1rl4dWUhZc8=
X-Google-Smtp-Source: APXvYqzoS3cmrFjhGoFahwXjn5XrvaHqS9urjLfv/htFj5ZxF4Nmm62U1Fh/oalgKpw86GrlVd7CsA==
X-Received: by 2002:a50:d949:: with SMTP id u9mr18570310edj.142.1568566388871;
        Sun, 15 Sep 2019 09:53:08 -0700 (PDT)
Received: from [192.168.43.13] ([109.126.145.74])
        by smtp.gmail.com with ESMTPSA id f8sm1045404eds.71.2019.09.15.09.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 09:53:08 -0700 (PDT)
To:     Hou Tao <houtao1@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Cc:     osandov@fb.com, ming.lei@redhat.com
References: <20190521075904.135060-1-houtao1@huawei.com>
 <20190521075904.135060-2-houtao1@huawei.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFmKBOQBEAC76ZFxLAKpDw0bKQ8CEiYJRGn8MHTUhURL02/7n1t0HkKQx2K1fCXClbps
 bdwSHrhOWdW61pmfMbDYbTj6ZvGRvhoLWfGkzujB2wjNcbNTXIoOzJEGISHaPf6E2IQx1ik9
 6uqVkK1OMb7qRvKH0i7HYP4WJzYbEWVyLiAxUj611mC9tgd73oqZ2pLYzGTqF2j6a/obaqha
 +hXuWTvpDQXqcOZJXIW43atprH03G1tQs7VwR21Q1eq6Yvy2ESLdc38EqCszBfQRMmKy+cfp
 W3U9Mb1w0L680pXrONcnlDBCN7/sghGeMHjGKfNANjPc+0hzz3rApPxpoE7HC1uRiwC4et83
 CKnncH1l7zgeBT9Oa3qEiBlaa1ZCBqrA4dY+z5fWJYjMpwI1SNp37RtF8fKXbKQg+JuUjAa9
 Y6oXeyEvDHMyJYMcinl6xCqCBAXPHnHmawkMMgjr3BBRzODmMr+CPVvnYe7BFYfoajzqzq+h
 EyXSl3aBf0IDPTqSUrhbmjj5OEOYgRW5p+mdYtY1cXeK8copmd+fd/eTkghok5li58AojCba
 jRjp7zVOLOjDlpxxiKhuFmpV4yWNh5JJaTbwCRSd04sCcDNlJj+TehTr+o1QiORzc2t+N5iJ
 NbILft19Izdn8U39T5oWiynqa1qCLgbuFtnYx1HlUq/HvAm+kwARAQABtDFQYXZlbCBCZWd1
 bmtvdiAoc2lsZW5jZSkgPGFzbWwuc2lsZW5jZUBnbWFpbC5jb20+iQJOBBMBCAA4FiEE+6Ju
 PTjTbx479o3OWt5b1Glr+6UFAlmKBOQCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQ
 Wt5b1Glr+6WxZA//QueaKHzgdnOikJ7NA/Vq8FmhRlwgtP0+E+w93kL+ZGLzS/cUCIjn2f4Q
 Mcutj2Neg0CcYPX3b2nJiKr5Vn0rjJ/suiaOa1h1KzyNTOmxnsqE5fmxOf6C6x+NKE18I5Jy
 xzLQoktbdDVA7JfB1itt6iWSNoOTVcvFyvfe5ggy6FSCcP+m1RlR58XxVLH+qlAvxxOeEr/e
 aQfUzrs7gqdSd9zQGEZo0jtuBiB7k98t9y0oC9Jz0PJdvaj1NZUgtXG9pEtww3LdeXP/TkFl
 HBSxVflzeoFaj4UAuy8+uve7ya/ECNCc8kk0VYaEjoVrzJcYdKP583iRhOLlZA6HEmn/+Gh9
 4orG67HNiJlbFiW3whxGizWsrtFNLsSP1YrEReYk9j1SoUHHzsu+ZtNfKuHIhK0sU07G1OPN
 2rDLlzUWR9Jc22INAkhVHOogOcc5ajMGhgWcBJMLCoi219HlX69LIDu3Y34uIg9QPZIC2jwr
 24W0kxmK6avJr7+n4o8m6sOJvhlumSp5TSNhRiKvAHB1I2JB8Q1yZCIPzx+w1ALxuoWiCdwV
 M/azguU42R17IuBzK0S3hPjXpEi2sK/k4pEPnHVUv9Cu09HCNnd6BRfFGjo8M9kZvw360gC1
 reeMdqGjwQ68o9x0R7NBRrtUOh48TDLXCANAg97wjPoy37dQE7e5Ag0EWYoE5AEQAMWS+aBV
 IJtCjwtfCOV98NamFpDEjBMrCAfLm7wZlmXy5I6o7nzzCxEw06P2rhzp1hIqkaab1kHySU7g
 dkpjmQ7Jjlrf6KdMP87mC/Hx4+zgVCkTQCKkIxNE76Ff3O9uTvkWCspSh9J0qPYyCaVta2D1
 Sq5HZ8WFcap71iVO1f2/FEHKJNz/YTSOS/W7dxJdXl2eoj3gYX2UZNfoaVv8OXKaWslZlgqN
 jSg9wsTv1K73AnQKt4fFhscN9YFxhtgD/SQuOldE5Ws4UlJoaFX/yCoJL3ky2kC0WFngzwRF
 Yo6u/KON/o28yyP+alYRMBrN0Dm60FuVSIFafSqXoJTIjSZ6olbEoT0u17Rag8BxnxryMrgR
 dkccq272MaSS0eOC9K2rtvxzddohRFPcy/8bkX+t2iukTDz75KSTKO+chce62Xxdg62dpkZX
 xK+HeDCZ7gRNZvAbDETr6XI63hPKi891GeZqvqQVYR8e+V2725w+H1iv3THiB1tx4L2bXZDI
 DtMKQ5D2RvCHNdPNcZeldEoJwKoA60yg6tuUquvsLvfCwtrmVI2rL2djYxRfGNmFMrUDN1Xq
 F3xozA91q3iZd9OYi9G+M/OA01husBdcIzj1hu0aL+MGg4Gqk6XwjoSxVd4YT41kTU7Kk+/I
 5/Nf+i88ULt6HanBYcY/+Daeo/XFABEBAAGJAjYEGAEIACAWIQT7om49ONNvHjv2jc5a3lvU
 aWv7pQUCWYoE5AIbDAAKCRBa3lvUaWv7pfmcEACKTRQ28b1y5ztKuLdLr79+T+LwZKHjX++P
 4wKjEOECCcB6KCv3hP+J2GCXDOPZvdg/ZYZafqP68Yy8AZqkfa4qPYHmIdpODtRzZSL48kM8
 LRzV8Rl7J3ItvzdBRxf4T/Zseu5U6ELiQdCUkPGsJcPIJkgPjO2ROG/ZtYa9DvnShNWPlp+R
 uPwPccEQPWO/NP4fJl2zwC6byjljZhW5kxYswGMLBwb5cDUZAisIukyAa8Xshdan6C2RZcNs
 rB3L7vsg/R8UCehxOH0C+NypG2GqjVejNZsc7bgV49EOVltS+GmGyY+moIzxsuLmT93rqyII
 5rSbbcTLe6KBYcs24XEoo49Zm9oDA3jYvNpeYD8rDcnNbuZh9kTgBwFN41JHOPv0W2FEEWqe
 JsCwQdcOQ56rtezdCJUYmRAt3BsfjN3Jn3N6rpodi4Dkdli8HylM5iq4ooeb5VkQ7UZxbCWt
 UVMKkOCdFhutRmYp0mbv2e87IK4erwNHQRkHUkzbsuym8RVpAZbLzLPIYK/J3RTErL6Z99N2
 m3J6pjwSJY/zNwuFPs9zGEnRO4g0BUbwGdbuvDzaq6/3OJLKohr5eLXNU3JkT+3HezydWm3W
 OPhauth7W0db74Qd49HXK0xe/aPrK+Cp+kU1HRactyNtF8jZQbhMCC8vMGukZtWaAwpjWiiH bA==
Subject: Re: [PATCH 1/2] block: make rq sector size accessible for block stats
Message-ID: <a23faff8-1d82-a101-dc27-d6e540b68c23@gmail.com>
Date:   Sun, 15 Sep 2019 19:52:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190521075904.135060-2-houtao1@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p7WXO99Qoq44bzH40DqsV3wpe5SdnsYQm"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p7WXO99Qoq44bzH40DqsV3wpe5SdnsYQm
Content-Type: multipart/mixed; boundary="jD08BZjsiLTwoAQEqWKdWdJhcykcTWwja";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Hou Tao <houtao1@huawei.com>, axboe@kernel.dk, linux-block@vger.kernel.org
Cc: osandov@fb.com, ming.lei@redhat.com
Message-ID: <a23faff8-1d82-a101-dc27-d6e540b68c23@gmail.com>
Subject: Re: [PATCH 1/2] block: make rq sector size accessible for block stats
References: <20190521075904.135060-1-houtao1@huawei.com>
 <20190521075904.135060-2-houtao1@huawei.com>
In-Reply-To: <20190521075904.135060-2-houtao1@huawei.com>

--jD08BZjsiLTwoAQEqWKdWdJhcykcTWwja
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

Works well for me
Tested-by: Pavel Begunkov <asml.silence@gmail.com>

Yet, take a look at the comment below.

By the way,
Fixes: 795fe54c2a828099e ("block: move blk_stat_add() to
__blk_mq_end_request()")


On 21/05/2019 10:59, Hou Tao wrote:
> +++ b/include/linux/blkdev.h
> @@ -202,9 +202,12 @@ struct request {
>  #ifdef CONFIG_BLK_WBT
>  	unsigned short wbt_flags;
>  #endif
> -#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
> -	unsigned short throtl_size;
> -#endif
> +	/*
> +	 * rq sectors used for blk stats. It has the same value
> +	 * with blk_rq_sectors(rq), except that it never be zeroed
> +	 * by completion.
> +	 */
> +	unsigned short stats_sectors;
It can handle max 32MiB. Can a request's data be larger than that?

> =20
>  	/*
>  	 * Number of scatter-gather DMA addr+len pairs after
> @@ -892,6 +895,7 @@ static inline struct request_queue *bdev_get_queue(=
struct block_device *bdev)
>   * blk_rq_err_bytes()		: bytes left till the next error boundary


--=20
Yours sincerely,
Pavel Begunkov


--jD08BZjsiLTwoAQEqWKdWdJhcykcTWwja--

--p7WXO99Qoq44bzH40DqsV3wpe5SdnsYQm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl1+bHAACgkQWt5b1Glr
+6XRBRAAgERNSaEpToqv1Xy1isJQeTfBVsouSQD+0PXC9IH5aQaFBWuMuapWTc0V
YyioLH34c7YmjYW89Qco3C3E6F4OUuTWdksAXgjD6fHfXYrlOJV73S0QBPq+Zhve
wEGG5pZ2vVU0H5VKiVsKl3lMgFIxf+AcclQDo+vhfznFoKvAp5jP5P7MvNYwxELd
nMLmMbLXNkm9nF3p3Fib0ILNjzPdGRq+NdzeC6r95cHe3U1FdELocHaWmhw+CL34
yJr8CYi4OLzibDsFEze2N7q6jRi8RMxwN73OViBUURdnoMW+XzpIX5c1sGAQ8Q/Y
5Gu9JpENfBXanKRJ+vtUXaDfUlNr+o/ifoPQ/LsWB/AF756PdJlvvBolaC2av6Bp
YAOnhguHMKePRe8uoNGcoZSbxSCFDvzL6R6ewJrHs0VmehyxEUgBuDyQ0UxZ3xQh
bS0ld0+nrx40IIQpKG68uUvj6R11MOpuDIGORrpn3Vk1jpYqx0tNob9kPwArQWc5
+RuyOmdDNKjbAdxK7Y9Yjew/nV8G/EFafwkFfbzEKIYy9LHaRCqkoE3j3eqrbIr6
UzPfOvQuyLW4rVZK7F+YZDzUypINzWHEUC9LIvCj5BfHsWk3mQQeiuuqdOt0qGJZ
HxAJ92ROrNomsW8KATEcOxNGlf5jhBYEhGQwllJsiAdMHK4o+zo=
=3mq1
-----END PGP SIGNATURE-----

--p7WXO99Qoq44bzH40DqsV3wpe5SdnsYQm--
