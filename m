Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFD4C3F6B0
	for <linux-block@archiver.kernel.org>; Fri, 29 Jul 2022 14:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbiG2O10 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jul 2022 10:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237077AbiG2O1Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 10:27:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EEA491FD;
        Fri, 29 Jul 2022 07:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=gmpvhVcEHBA5pP+ZPpZ+i/vZja
        5rJoknTIAnk3KPRiBVh78+5d/fpc9tlz8m1QNQ9wOrV01y9Rkd+/g/L1JBTfbyWufQ7k+LovDmITt
        vp9ZlDIqWxqYqlpFZbLPoIWanCzS19MrUJbjKWMnOJkY1vUZgE/KZ8sKr+DWaL8QhMGQOt/iwe5EP
        e/kiw0jcoLMfTIqaDLSG8NGGOYX4Mjjl/odWKEcbpn98060othkG7hWrUG4mYpfDopHPnmHRaPUtI
        wKZsaV7R8Aaa6vmKJss7GmN2Y5t86ZzKTWIggvj6YUBxFysipQGGm66kemsrN6hQjKswHoiZOnvV6
        EkURD62g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oHQxY-005VbT-Kg; Fri, 29 Jul 2022 14:27:24 +0000
Date:   Fri, 29 Jul 2022 07:27:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     gjoyce@linux.vnet.ibm.com
Cc:     linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, jarkko@kernel.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, gjoyce@ibm.com, nayna@linux.ibm.com
Subject: Re: [PATCH 2/3] block: sed-opal: Implement IOC_OPAL_REVERT_LSP
Message-ID: <YuPuTBfK6aYoM2j6@infradead.org>
References: <20220727181422.3504563-1-gjoyce@linux.vnet.ibm.com>
 <20220727181422.3504563-3-gjoyce@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727181422.3504563-3-gjoyce@linux.vnet.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
