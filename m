Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E74DC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A4D20835
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="y5z641wn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfCDNT1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:19:27 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34174 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfCDNT0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 08:19:26 -0500
Received: by mail-ed1-f66.google.com with SMTP id a16so4225715edn.1
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 05:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BpB0mlTpKJthWSpeO01hDIegcxL91NlCr5n1zXuhDMg=;
        b=y5z641wnNMJB3pb24k9PNFjRAxUr6TQAe7nbeULpeV2G4AmoveUwIO2HaNLjceth/P
         qVFdN3yIhpi4Xq0cNXe3A7YKn5TXZvYea67Hpd8l1nUIykD+x0cWkmSDs3Fuqf5U1LNx
         VTDM8sXi4SVaLuQSzsKhQK2vjDk+ebTzOcw7q6yFGG+OQB67u57kQeeh53x80VRZ+NBD
         SDQDTYF1p3GIwS0+c60P58MevPqbnoPcpYTwvTIzthjWXjOC891nySa7y6SdUY2thyFb
         4Ij+GgNsdx2v5tgXvFNjXKqesQQM53CLIeDhR6DK6dRjFW9erDzTBVpV29I0DVlAp0/R
         ylBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BpB0mlTpKJthWSpeO01hDIegcxL91NlCr5n1zXuhDMg=;
        b=RHCXufQj1eHgMfj4hucQkhN1FFiJksRoWHyhmu0uFk87SJ1bhz3xNXsbBioPBwZUpn
         IWCoznuT+tb0qQkxBLKV3K+IQnUGmf0SROipxQ7CRIe8abo4RJfOLOR6j0ubHhu48wig
         FwRe6uJrTVR/ZEt92MngV2/unBIhVYkzwaRUMQjX2eGy0Tgj2ucyzajc+WMXI6xnHSfJ
         6ZD90P+2qK/b9kwcw/fxXBCYyczauc9hOrIeryRQhXjWNQ9XjAfXU0kvg8cJ/shOfbnR
         qkxxQx4ElS4BFDtP9t3ljG9rmg0XSJywe3frQgJHRLVX0bkBSgqEiLYVDBBm+RLd0scV
         ZPYw==
X-Gm-Message-State: APjAAAXk+uJ0bdHLIxHqQNWk92lD03uJdOK4GAY/FfaUwt4ZjUjWQms5
        jQwUyJY6kQq0qA68mgTQ4BaD8g==
X-Google-Smtp-Source: APXvYqy3eK7Uq5TofVaTZi6CriOcmfmLh6O5yV7Z+mnRdas/9USp5Gyls7xLwtEIUy1i8Sdjz1ZeKQ==
X-Received: by 2002:a50:ac58:: with SMTP id w24mr14977934edc.287.1551705565679;
        Mon, 04 Mar 2019 05:19:25 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id gl18sm1202076ejb.49.2019.03.04.05.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:19:24 -0800 (PST)
Subject: Re: [PATCH 12/13] lightnvm: pblk: close opened chunks
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Klaus Jensen <klaus.jensen@cnexlabs.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-13-igor.j.konopko@intel.com>
 <C2286529-B0FE-4DFE-8CD1-5BB6591549A4@javigon.com>
 <CANr-nt1kkQ1H4TgF9-3yR-_S+-HkNwEnGu_t5Z607jAV30cpqw@mail.gmail.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <0ee7b3e6-f471-1996-0c89-457c96f950c5@lightnvm.io>
Date:   Mon, 4 Mar 2019 14:19:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CANr-nt1kkQ1H4TgF9-3yR-_S+-HkNwEnGu_t5Z607jAV30cpqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> 
> + Klaus whom I discussed this with.
> Yeah, i think that "early reset" is a nice feature. It would be nice
> to extend the OCSSD spec with a new capabilities bit indicating if
> this is indeed supported or not.
> Matias: what do you think?

I don't mind as long as it is gated by a feature bit. An ECN can be made 
to fix that up and then software can be updated to read that bit for 
what to do.
