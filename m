Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67050C4332F
	for <linux-block@archiver.kernel.org>; Mon, 21 Mar 2022 12:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346746AbiCUMDQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 08:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347050AbiCUMDP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 08:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD36C53E2F
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 05:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647864108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjyieAFQj3bcVjxdPEDIjVTjL278YKH95kf+yFJHAWk=;
        b=XkJGtS4eAvnKpNIaz8QX4XLpjNLeFWhPWGhL/JOamaVjjwehye3806k+MYCJrWratEPnEa
        LyVJjd3lu9DdOcuWtCyrXhxDgOKA9EUQqna9c1nvchluMlIwQu89hbRUEw02SF4tdDIgqw
        I3dLrcBpoVWGsfOb7mgku2bRCaVmmPM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-Gc-YAZZgOtODheWWLJZmdg-1; Mon, 21 Mar 2022 08:01:47 -0400
X-MC-Unique: Gc-YAZZgOtODheWWLJZmdg-1
Received: by mail-wr1-f69.google.com with SMTP id f18-20020adf9f52000000b00203d86759beso3027217wrg.11
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 05:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=hjyieAFQj3bcVjxdPEDIjVTjL278YKH95kf+yFJHAWk=;
        b=BH7JHRle8tY2SXHas16TI5Hc3dHk2sWFUNZBt+QUThdMEXbamUnTtAm3Hgd3FTa+1J
         uohT7S6kYuxoVdmoNcbrqUqvuhW1ytrmM0PSJIfCG94yUnvwDITvXFwJzZ5OWFGDAHCy
         IiiSGfuQntfEUsjoGtdP0hj2P8ZpDjnEd/P4hziCcOM81mXgIY4Fs5osTIG3kFug7uy2
         Ko0EIEISsjxlQ4RT1R+HcCbMlppB9nTnTDqhta9GqxkqkK725cIMQrhFh+t9QBZO46x0
         bthHLL8ytdIZkVjn4ntYm1rR95DvZ5oIwZgsMc3tE3bxsVKYqcjjYSEHLweTdQEEISfF
         OguA==
X-Gm-Message-State: AOAM533+ollxf02BAIjqKqkneCRbOntpqL8mAV1kCYYyQh+NujDJ2v6c
        L4EuBvKKrFZYRTh5DyaA381rdevME2cDosCPGiO+jtg9mqBCIW2Ig9ObW0syzyLcXFJo1gDO8+q
        G6F4VWbcTB0GElsWTXfk9BwA=
X-Received: by 2002:a5d:6405:0:b0:204:1ef:56e8 with SMTP id z5-20020a5d6405000000b0020401ef56e8mr8378175wru.677.1647864106165;
        Mon, 21 Mar 2022 05:01:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhZuEfJSaXjpaErJyh2L9DkMAaRb0WEaJXZhhj0Z+2/QVCT0rFeZuYjApA/Lz7WeWZRTfZiw==
X-Received: by 2002:a5d:6405:0:b0:204:1ef:56e8 with SMTP id z5-20020a5d6405000000b0020401ef56e8mr8378159wru.677.1647864105940;
        Mon, 21 Mar 2022 05:01:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4900:849b:f76e:5e1f:ff95? (p200300cbc7044900849bf76e5e1fff95.dip0.t-ipconnect.de. [2003:cb:c704:4900:849b:f76e:5e1f:ff95])
        by smtp.gmail.com with ESMTPSA id a1-20020a056000188100b002041a652dfdsm1639674wri.25.2022.03.21.05.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 05:01:45 -0700 (PDT)
Message-ID: <a37e9ba2-354b-0b75-cb05-bc730cb30151@redhat.com>
Date:   Mon, 21 Mar 2022 13:01:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC 2/3] mm: export zap_page_range()
Content-Language: en-US
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        linux-mm@kvack.org, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     linux-block@vger.kernel.org, xuyu@linux.alibaba.com,
        bostroesser@gmail.com
References: <20220318095531.15479-1-xiaoguang.wang@linux.alibaba.com>
 <20220318095531.15479-3-xiaoguang.wang@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220318095531.15479-3-xiaoguang.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18.03.22 10:55, Xiaoguang Wang wrote:
> Module target_core_user will use it to implement zero copy feature.
> 
> Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> ---
>  mm/memory.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 1f745e4d11c2..9974d0406dad 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1664,6 +1664,7 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
>  	mmu_notifier_invalidate_range_end(&range);
>  	tlb_finish_mmu(&tlb);
>  }
> +EXPORT_SYMBOL_GPL(zap_page_range);
>  
>  /**
>   * zap_page_range_single - remove user pages in a given range

To which VMAs will you be applying zap_page_range? I assume only to some
special ones where you previously vm_insert_page(s)_mkspecial'ed pages,
not to some otherwise random VMAs, correct?

-- 
Thanks,

David / dhildenb

