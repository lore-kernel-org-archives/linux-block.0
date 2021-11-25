Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C077C433EF
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 13:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355450AbhKYN54 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 08:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355551AbhKYNzz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 08:55:55 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D453C061756
        for <linux-block@vger.kernel.org>; Thu, 25 Nov 2021 05:46:54 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id t11so6172951qtw.3
        for <linux-block@vger.kernel.org>; Thu, 25 Nov 2021 05:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=yhu8IuHe2ketytEpljISgzXf7tR3b1cFqSmZT69CeP4=;
        b=F1CF0s7YNw1k/kIiiaZFRQa/6r7gy6zwZx76MMU38a8GOjKxC7GyNx220XcMkIP5pk
         qVYo4BqeG584V42bxZVJVsj9DaZAUV/Sv53mqyx8LXNj7HGFCmiosl66cvjd/IVKvftD
         529ksbg+8ihsKoWxQrd4sc+pmSn/RcoOvIAAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=yhu8IuHe2ketytEpljISgzXf7tR3b1cFqSmZT69CeP4=;
        b=7r0PlCUmSQ+LQtcI2uQVjfzWXfEZDbXTbXGNatUqWchGvmqjGkmGu6GrjIggx0IvI+
         iSzNHZspSnixyq+w0EL2Q5471JQ4IbLEmXxjIqsV98MI8KvXqPwkYos0+APE1ji2OG2T
         pFhG3jKsdNpOy+FavqJYS/HcKNI7kQDolzXQwgBallIFjctOHwROcrC7hsaPkSWxqBOv
         21cJl8XMiQMNduNcoFQ8uoYprVHdQT/6ad8qEq7VtXlF7RQiaoy4PX25SPvivj4AdMXo
         3gV5cxZXCiSHvOz9eEEEZppYwg5sKdGhZvQKP50N7EvG1RQy6It+dKR+weqoZUNb+JCg
         J2WQ==
X-Gm-Message-State: AOAM531fwt/qzaGz1JnkptDzY2RVMzyMY52rRifgZh/YZQIuY4N18N38
        7432maxR1IbkE6tzUu2TqZO4a6SPmRGazS2UnbT2tw==
X-Google-Smtp-Source: ABdhPJxnW0Fh2dIo9Lnnc7Q5RyULA82JtAwaEEWbdcj3SSrQi5EWR75hrsYM/TQvV6IttLdXI+EZLckdmHzMCCRuBFY=
X-Received: by 2002:ac8:5a0b:: with SMTP id n11mr7745695qta.485.1637848013062;
 Thu, 25 Nov 2021 05:46:53 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <1635852455-39935-1-git-send-email-john.garry@huawei.com>
 <7fba1b1e-63a6-6315-e5ca-6d5ae9de6dbb@huawei.com> 0c3ab8737fe86c522ee4f10fd5ffc102@mail.gmail.com
In-Reply-To: 0c3ab8737fe86c522ee4f10fd5ffc102@mail.gmail.com
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJUjX6rU/P5SPFd3QoAV879Bj3AJQMPa4fEqvLl83CAD4OWkA==
Date:   Thu, 25 Nov 2021 19:16:51 +0530
Message-ID: <b18285f4aa0e8be796aea19cdfde0293@mail.gmail.com>
Subject: RE: [PATCH RFT 0/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for
 shared tags
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, hare@suse.de
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000009097f05d19d350a"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--00000000000009097f05d19d350a
Content-Type: text/plain; charset="UTF-8"

> -----Original Message-----
> From: Kashyap Desai [mailto:kashyap.desai@broadcom.com]
> Sent: Monday, November 15, 2021 10:02 PM
> To: 'John Garry' <john.garry@huawei.com>; 'axboe@kernel.dk'
> <axboe@kernel.dk>
> Cc: 'linux-block@vger.kernel.org' <linux-block@vger.kernel.org>; 'linux-
> kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>;
> 'ming.lei@redhat.com'
> <ming.lei@redhat.com>; 'hare@suse.de' <hare@suse.de>
> Subject: RE: [PATCH RFT 0/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter()
> for shared tags
>
> > Hi Kashyap,
> >
> > Any chance you can try this series or give an update on the issue
> > reported earlier?
>
> John -
>
> I will try something this week and let you know.

John - I tested patchset and looks good.  Issue reported at below thread is
fixed.
https://lore.kernel.org/linux-block/e4e92abbe9d52bcba6b8cc6c91c442cc@mail.gmail.com/

Here is perf top data.

5.70%  [megaraid_sas]                [k] complete_cmd_fusion
   3.80%  [megaraid_sas]                [k]
megasas_build_and_issue_cmd_fusion
   2.75%  [kernel]                      [k] syscall_return_via_sysret
   2.68%  [kernel]                      [k] entry_SYSCALL_64
   2.22%  [kernel]                      [k] io_submit_one
   2.19%  [megaraid_sas]                [k] megasas_build_ldio_fusion
   1.95%  [kernel]                      [k] llist_add_batch
   1.80%  [kernel]                      [k] llist_reverse_order
   1.79%  [kernel]                      [k] scsi_complete
   1.73%  [kernel]                      [k] scsi_queue_rq
   1.66%  [kernel]                      [k] check_preemption_disabled
   1.37%  [megaraid_sas]                [k] megasas_queue_command
   1.16%  [kernel]                      [k] native_irq_return_iret
   1.11%  [kernel]                      [k] aio_complete_rw
   1.07%  [kernel]                      [k] read_tsc
   1.06%  fio                           [.] __fio_gettime
   1.05%  [kernel]                      [k] flush_smp_call_function_queue
   1.03%  [kernel]                      [k] blk_complete_reqs
   1.00%  [kernel]                      [k] blk_mq_free_request
   0.98%  [kernel]                      [k] sbitmap_get


I will continue testing and let you know how it goes.


Kashyap

>
> >
> > thanks @ Ming for the reviews.
> >
> > Cheers,
> > John
> >

--00000000000009097f05d19d350a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
P3lSxcw4Cg90iKHqfpwLnGNc9AGXHMxUCukpnAHRlivljilKHMx1ymb180BLmtF+ZLm6KrFLQWzB
4KeiUOMtKM13wJrQubqTeZgB1XA+89jeLYlxagVsMyksdwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUkTOZp9jXE3yPj4ieKeDT
OiNyCtswDQYJKoZIhvcNAQELBQADggEBABG1KCh7cLjStywh4S37nKE1eE8KPyAxDzQCkhxYLBVj
gnnhaLmEOayEucPAsM1hCRAm/vR3RQ27lMXBGveCHaq9RZkzTjGSbzr8adOGK3CluPrasNf5StX3
GSk4HwCapA39BDUrhnc/qG5vHwLrgA1jwAvSy8e/vn4F4h+KPrPoFNd1OnCafedbuiEXTqTkn5Rk
vZ2AOTcSbxvmyKBMb/iu1vn7AAoui0d8GYCPoz8shf2iWMSUXVYJAMrtRHVJr47J5jlopF5F2ghC
MzNfx6QsmJhYiRByd8L9sUOjp/DMgkC6H93PyYpYMiBGapgNf6UMsLg/1kx5DATNwhPAJbkxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxwO04DXOeYbZtr
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEH1GTFQGAaia9f3hJj+kA/FzoJx
wUa7wjuwLxr3aSnJMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MTEyNTEzNDY1M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAZ9DbXUOvBe8hl7vaghyCoVgQnzzgKoP4JB6RvjPPqdTGd
fN3WZbOEUji9WjkiF8akKiUM0v0bMtDLBOSCDUafkp08VWzJBCnNRxXhzm7jqZt6fUAuKmlDkpm6
QuAxJMHLsPl/mYppmDpiWUCEaD/9G2xaqjRq6iLcd6Rw0dUVwu371JCfYLeNI/ho+Y5WNvsqCg8N
QgMc4R7XPJ18i45gPiA4AzJFqy9dDqMw2XEYrcrgQqfyxuVivlOsqUmXEYppHd39FTIKo9XbF6ad
0g3+UTFsjZ0l2dmPIqvIJyU0ksmKD9ooeWcWdWkVJU6kSw73hpxvIxmfZdORkKGPVqc2
--00000000000009097f05d19d350a--
