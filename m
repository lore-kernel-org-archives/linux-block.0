Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C14AC64E7A
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 11:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38F1B20857
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 11:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wl/tuJ1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgKYLRP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 06:17:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727268AbgKYLRP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 06:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606303033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JS6xr5LtUlr5j8jszduDjhIpqmpjZKnCMk7lXNfXS5E=;
        b=Wl/tuJ1FiP2YQPQt00jbpdYlwbpjsaj3PTDMJbMHFAmUv5pef1HEo92u09hbHrscg3nOfy
        4jrgqsLlBHffjf4HOM7V7HMV6DzunbA2IUz4zzyGf35hWy0UM5qFJQ9nVmtfZwhZ+kHZuZ
        OTGu/TzSjCZLr/BsFfZhV4CKFoRGY7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-AvhW3TIpOWq-3zY-Q-MqcQ-1; Wed, 25 Nov 2020 06:17:09 -0500
X-MC-Unique: AvhW3TIpOWq-3zY-Q-MqcQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4C9A1E7C1;
        Wed, 25 Nov 2020 11:17:07 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-83.ams2.redhat.com [10.36.113.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A63D10023BF;
        Wed, 25 Nov 2020 11:17:04 +0000 (UTC)
From:   Laurent Vivier <lvivier@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Michael S . Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 1/2] genirq: add an irq_create_mapping_affinity() function
Date:   Wed, 25 Nov 2020 12:16:56 +0100
Message-Id: <20201125111657.1141295-2-lvivier@redhat.com>
In-Reply-To: <20201125111657.1141295-1-lvivier@redhat.com>
References: <20201125111657.1141295-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This function adds an affinity parameter to irq_create_mapping().
This parameter is needed to pass it to irq_domain_alloc_descs().

irq_create_mapping() is a wrapper around irq_create_mapping_affinity()
to pass NULL for the affinity parameter.

No functional change.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 include/linux/irqdomain.h | 12 ++++++++++--
 kernel/irq/irqdomain.c    | 13 ++++++++-----
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 71535e87109f..ea5a337e0f8b 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -384,11 +384,19 @@ extern void irq_domain_associate_many(struct irq_domain *domain,
 extern void irq_domain_disassociate(struct irq_domain *domain,
 				    unsigned int irq);
 
-extern unsigned int irq_create_mapping(struct irq_domain *host,
-				       irq_hw_number_t hwirq);
+extern unsigned int irq_create_mapping_affinity(struct irq_domain *host,
+				      irq_hw_number_t hwirq,
+				      const struct irq_affinity_desc *affinity);
 extern unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec);
 extern void irq_dispose_mapping(unsigned int virq);
 
+static inline unsigned int irq_create_mapping(struct irq_domain *host,
+					      irq_hw_number_t hwirq)
+{
+	return irq_create_mapping_affinity(host, hwirq, NULL);
+}
+
+
 /**
  * irq_linear_revmap() - Find a linux irq from a hw irq number.
  * @domain: domain owning this hardware interrupt
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cf8b374b892d..e4ca69608f3b 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -624,17 +624,19 @@ unsigned int irq_create_direct_mapping(struct irq_domain *domain)
 EXPORT_SYMBOL_GPL(irq_create_direct_mapping);
 
 /**
- * irq_create_mapping() - Map a hardware interrupt into linux irq space
+ * irq_create_mapping_affinity() - Map a hardware interrupt into linux irq space
  * @domain: domain owning this hardware interrupt or NULL for default domain
  * @hwirq: hardware irq number in that domain space
+ * @affinity: irq affinity
  *
  * Only one mapping per hardware interrupt is permitted. Returns a linux
  * irq number.
  * If the sense/trigger is to be specified, set_irq_type() should be called
  * on the number returned from that call.
  */
-unsigned int irq_create_mapping(struct irq_domain *domain,
-				irq_hw_number_t hwirq)
+unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
+				       irq_hw_number_t hwirq,
+				       const struct irq_affinity_desc *affinity)
 {
 	struct device_node *of_node;
 	int virq;
@@ -660,7 +662,8 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 	}
 
 	/* Allocate a virtual interrupt number */
-	virq = irq_domain_alloc_descs(-1, 1, hwirq, of_node_to_nid(of_node), NULL);
+	virq = irq_domain_alloc_descs(-1, 1, hwirq, of_node_to_nid(of_node),
+				      affinity);
 	if (virq <= 0) {
 		pr_debug("-> virq allocation failed\n");
 		return 0;
@@ -676,7 +679,7 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 
 	return virq;
 }
-EXPORT_SYMBOL_GPL(irq_create_mapping);
+EXPORT_SYMBOL_GPL(irq_create_mapping_affinity);
 
 /**
  * irq_create_strict_mappings() - Map a range of hw irqs to fixed linux irqs
-- 
2.28.0

