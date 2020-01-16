Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE68C33CB3
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 04:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EC22075B
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 04:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1aDWE3Bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgAPEew (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 23:34:52 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:37644 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730635AbgAPEew (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 23:34:52 -0500
Received: by mail-pf1-f181.google.com with SMTP id p14so9586886pfn.4
        for <linux-block@vger.kernel.org>; Wed, 15 Jan 2020 20:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8QzSJozHLO4jdrBrMFo5BD1QLBparz+PLwkptG0p09c=;
        b=1aDWE3Bs24yOc+IXxfzmyDBFqfcbNXtbMGf+FZpcCwFV5VgxHGC1cOtvNbcI+6IA03
         ncogLkfvDmP/pt7XvrNsXDpcESP9h8S9m7e0kazg3D8CaK/qGPZU7IL+13TfY/FmhUfM
         5eD8fMKLowq2A710lcvp4HIv8m91KKh7E3a4MRoHJwH2yGTf4PhrdKX7kCc7Wq686402
         NU0Ymnryvzq19SREEGq/Gb1isJSuoJ8Ghj4k8H1Qn2E+CLoK7KVbW4UZQr0BsvG6dMRw
         64aEFhvvyyId5vlfhRRqQy3e3BiB7HiCbxz9pf++e9mwRYt7Le/mixm/iZnGLkocGDS+
         sEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8QzSJozHLO4jdrBrMFo5BD1QLBparz+PLwkptG0p09c=;
        b=RJTJfc3ekDTpfcBUydwpeU0OuBnWYAjWCl58u7OqtOkX85S9pF1hib+gWH6ukDVYsN
         tXrX+aM8HmRf/GNcJ/3nZ1Cs1cHpT43bUzmcjbf03xfnfpvCA7a3oLLnPLA7kebA4Fwc
         R54hBxARpuTp+KeTSCOP9xjByP227Z+9klez1zOimvRAIKh+AcNPSyQ46vkveQ5XxQSI
         jATJGtspxyNb7gDtEAtZmYDj+FXIiRHdovBhpgBiaysMi8Lk8yCR7+nuVV30fLfDZc8D
         F+0j61kIiYY67TmA683E8JsC7ZsY9H5t5knOjyK1datBPutZNgZMInF0FxKMzePwIir2
         Ks0g==
X-Gm-Message-State: APjAAAVbfUCeBDDFFALP7AogcGHj/JhmEmR3gd5ChJzhHBefnF0RkGAW
        LYFgDaiKgbihY3xHhCf+kzNkjHO2/iU=
X-Google-Smtp-Source: APXvYqxlWWA2xx4n7aKwDvzX40N8vUtJzrEzrcpXMr3lixgYlTLS2X20MmwYPmMa7I4rWUmhLiCrTg==
X-Received: by 2002:a62:c541:: with SMTP id j62mr35643524pfg.237.1579149291735;
        Wed, 15 Jan 2020 20:34:51 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id z19sm22859450pfn.49.2020.01.15.20.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 20:34:51 -0800 (PST)
Subject: Re: [RFC 1/2] io_uring: clear req->result always before issuing a
 read/write request
To:     Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Cc:     linux-block@vger.kernel.org
References: <1579142266-64789-1-git-send-email-bijan.mottahedeh@oracle.com>
 <1579142266-64789-2-git-send-email-bijan.mottahedeh@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4e20c457-da35-6433-dfd2-82877e7ccc6a@kernel.dk>
Date:   Wed, 15 Jan 2020 21:34:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579142266-64789-2-git-send-email-bijan.mottahedeh@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/15/20 7:37 PM, Bijan Mottahedeh wrote:
> req->result is cleared when io_issue_sqe() calls io_read/write_pre()
> routines.  Those routines however are not called when the sqe
> argument is NULL, which is the case when io_issue_sqe() is called from
> io_wq_submit_work().  io_issue_sqe() may then examine a stale result if
> a polled request had previously failed with -EAGAIN:
> 
>         if (ctx->flags & IORING_SETUP_IOPOLL) {
>                 if (req->result == -EAGAIN)
>                         return -EAGAIN;
> 
>                 io_iopoll_req_issued(req);
>         }
> 
> and in turn cause a subsequently completed request to be re-issued in
> io_wq_submit_work().

Looks good, thanks.

-- 
Jens Axboe

