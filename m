Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A38C2D0E2
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 13:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F002396D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 13:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="yy2bl6Hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIVNRT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 09:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgIVNRT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 09:17:19 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154D8C061755
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2020 06:17:19 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id db4so9471220qvb.4
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2020 06:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y7hBRDL7D6Os8jd/ujBfUgL9LgsIqC36Ea7y4QNnNwA=;
        b=yy2bl6Hywwn6atQQyV2G+5KhajzE8adC57JKYyO5qlSR6pM4IYuB6FZgr2Ll4TJsc2
         W0IPwRUfm18BUiFxMnTFwVqlAIbQNnsYVndZDjuF/qzpIkNARg/hFwRvEW4xHWSAi058
         hWFfJwDgGgLG+OgdXgib5RqvCUseRQ1wZFD7ZdXE7i3TcvZMVRIBF/zqQbwZS6I4aua4
         3wILroqhMyw8qSTVsuCJcKBYAdMZQLWgksgRCimFzC7XavG72jEKYh+laBjdkBEh7YrQ
         Oq3GuCIj2vHWE59D1ZdZn5dzWhZ0pOl42QuDbJqKrVuFn5riMVzt016oIyUFLSJApNHT
         yTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y7hBRDL7D6Os8jd/ujBfUgL9LgsIqC36Ea7y4QNnNwA=;
        b=ZREcIzZ8YKIevquv2+zG24bHgiXKkX/f6HESUdcRMNPoF4SWwLDxNkUgm/UYBot8ek
         wIf2WhoANLJM2yYWZp6DrruoKJfApkQ0UY9DgDTLRCTQdp1a57xJEFVgqxLgL13VFkeR
         RlN9WERGCtFfzRKUKqFcjYrKQCZoTG4IBOjnOdRUVnjZaYCudWAp0PkFFAsCoPKLc6NL
         LA+HFo9yR7pAYP6/iw7f9Je0i4yPfEfDo8Vne8uI9acX0Wop8Pif2g+EPwGOVE2kBCyv
         R+gSGVHDYJR6rNxbFkHpvywOUNjPQ9Xm0IUdTO5hWSmZr16JYYizsfoGbZQmlOG4TpYV
         QwTg==
X-Gm-Message-State: AOAM531jZqaaR3dgGCLjbxauf9n64uvXQzVPu+ea7pMeJHDMysPVr8PD
        Du/BHJaCMvGer7MY0PxcGUvlXg==
X-Google-Smtp-Source: ABdhPJwZakf/ID6zTVvXKm89xV38c1oiFCba0j711DtvgOMif1ocu0KVL2Pz9lwN8fy6w9TlPobDsQ==
X-Received: by 2002:a0c:a95e:: with SMTP id z30mr5836737qva.58.1600780638198;
        Tue, 22 Sep 2020 06:17:18 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f76sm11133910qke.19.2020.09.22.06.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 06:17:17 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] nbd: introduce a client flag to do zero timeout
 handling
To:     Hou Pu <houpu@bytedance.com>, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
References: <20200922033457.46227-1-houpu@bytedance.com>
 <20200922033457.46227-3-houpu@bytedance.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4a81b066-86d2-8532-f540-31ef9830e26b@toxicpanda.com>
Date:   Tue, 22 Sep 2020 09:17:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200922033457.46227-3-houpu@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/21/20 11:34 PM, Hou Pu wrote:
> Introduce a dedicated client flag NBD_RT_WAIT_ON_TIMEOUT to reset
> timer in nbd_xmit_timer instead of depending on tag_set.timeout == 0.
> So that the timeout value could be configured by the user to
> whatever they like instead of the default 30s. A smaller timeout
> value allow us to detect if a new socket is reconfigured in a
> shorter time. Thus the io could be requeued more quickly.
> 
> In multiple sockets configuration, the user could also disable
> dropping the socket in timeout by setting this flag.
> 
> The tag_set.timeout == 0 setting still works like before.
> 
> Signed-off-by: Hou Pu <houpu@bytedance.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
