Return-Path: <SRS0=eZc3=D2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9420C433DF
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 17:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D455222B8
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 17:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0e95TsUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbgJSRXu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Oct 2020 13:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbgJSRXu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Oct 2020 13:23:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B267FC0613CE
        for <linux-block@vger.kernel.org>; Mon, 19 Oct 2020 10:23:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x13so321573pfa.9
        for <linux-block@vger.kernel.org>; Mon, 19 Oct 2020 10:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=m9yDz6jsfkl8I4WwGG8Nd/lVTcCTRXN3HWZNgzXsp4E=;
        b=0e95TsUR7v0CLtoa8YRBbvAHeoWB96sc0KKgqqYcvM5oMJTphsnRM52cmcwxle0o4K
         1nYQFXgQDtZ39b6CdsRZkifsV3LwoxGWc6rTmEP/FDiQpb1wz0gwhVA4VZFsmcPTFfMn
         vB3AU3nSWJaKiM8naZerYkjG+c/WkSOzA4iMKVNdxgdfcp9XUftvP8da4Js3obXtWGoi
         CY2mXO6cYc7jQeU39AupOao6iCME+dQyPuDl/7zAV7w7SOX7dAQpYx4onXy4Hqeze1wq
         px02vvtzy1zBetanFakwNOKrRr93MdwIBO1uaUuJXC0lZi7Ul4IlO2jXxcB9xPHhkh8F
         ExjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m9yDz6jsfkl8I4WwGG8Nd/lVTcCTRXN3HWZNgzXsp4E=;
        b=Ru1H/UzpMCL3/mHzZAsE4/aJdLkJNStQlcA8vwSOVSejeY8ntixwIZ95ZRWk9pAJEq
         EIVKxx/+V3+KZaF0ikNw1/He3QZ6U6VYsEA7P4gKXVbl93NlGsGy3Gf98LAsavfPsJ4J
         qlZZ79s0g4qN5VUHdYIxyroO5v6xOisYBbruVqxOD7hGM6Xt68iD5Gl5dvRrvJowp/kG
         tT7lRvsDQOCnZftF/0p7k9DgauJtW1qEWmR120tqqcIUrSpraISYgSiG3+0gadTVIlcR
         VUNyhNzJ+XrIXfCYAWMbd4jLjw7gTtdTerDa/N2jLLMaW6lGt5MvfwMq++Jf+iTpQtiL
         nYBQ==
X-Gm-Message-State: AOAM532Q+/3iwDtVIg1DfPkq9l47fHcdPoBq1p3zd5XAU4taRCuOxXse
        HGq4Mw7ptj+62no7d8iNnYegvw==
X-Google-Smtp-Source: ABdhPJwsqWVBKojPmoF3yeXCiHiiQLSVFNz5YucRTA0U9YYMJCFfkI1WoiaRIMRiDX/5XYmhDYI//g==
X-Received: by 2002:a63:1e21:: with SMTP id e33mr631531pge.270.1603128230105;
        Mon, 19 Oct 2020 10:23:50 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21c8::169d? ([2620:10d:c090:400::5:499c])
        by smtp.gmail.com with ESMTPSA id b5sm221170pgi.55.2020.10.19.10.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 10:23:49 -0700 (PDT)
Subject: Re: [PATCH] block/elevator: reduce the critical section
To:     Hui Su <sh_def@163.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201019164246.GA79115@rlk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ea4495c3-0003-786d-82e4-3693f349890a@kernel.dk>
Date:   Mon, 19 Oct 2020 11:23:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019164246.GA79115@rlk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/20 10:42 AM, Hui Su wrote:
> @@ -633,23 +633,21 @@ static struct elevator_type *elevator_get_default(struct request_queue *q)
>   */
>  static struct elevator_type *elevator_get_by_features(struct request_queue *q)
>  {
> -	struct elevator_type *e, *found = NULL;
> +	struct elevator_type *e = NULL;
>  
>  	spin_lock(&elv_list_lock);
> -
>  	list_for_each_entry(e, &elv_list, list) {
>  		if (elv_support_features(e->elevator_features,
>  					 q->required_elevator_features)) {
> -			found = e;
>  			break;
>  		}
>  	}
> +	spin_unlock(&elv_list_lock);
>  
> -	if (found && !try_module_get(found->elevator_owner))
> -		found = NULL;
> +	if (e && !try_module_get(e->elevator_owner))
> +		e = NULL;
>  
> -	spin_unlock(&elv_list_lock);
> -	return found;
> +	return e;
>  }

This looks wrong as well. If we don't match the elevator, then we just
return the last one. Or maybe even a totally invalid entry, depending on
how the list iteration works.


-- 
Jens Axboe

