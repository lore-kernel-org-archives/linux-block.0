Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E10EC433FE
	for <linux-block@archiver.kernel.org>; Mon, 11 Oct 2021 18:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5192660E90
	for <linux-block@archiver.kernel.org>; Mon, 11 Oct 2021 18:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbhJKSZU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Oct 2021 14:25:20 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:32966 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234411AbhJKSZQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Oct 2021 14:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1633976594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1VgHaMSHjzT/0zjQ0pI4WCxHhzXq+lVzVgnR2S6Fmzo=;
        b=Y1kkDe/TvS8jP8zpu3ounJ4+DEMHLFXRW6LdV5uGD/gLN548q7KPTEbYKQ0+KTWR3s9KuU
        /YhKIhatuGOpKPz+eM1Z+luNCuQQ72TxnluHFF0THv7H7SjOghJrMAM0GwlJF2sNVjpjQs
        63NrbBidrZN8ptUdWL9WpRHlR5Oko6s=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2053.outbound.protection.outlook.com [104.47.10.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-24-c2OI4-q0NdiYmOVrVFtb5A-1; Mon, 11 Oct 2021 20:23:13 +0200
X-MC-Unique: c2OI4-q0NdiYmOVrVFtb5A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1zqaIgtoB9dQdhmtegqdfD+DLJjKzlWCdUT0nqQbzv0vx0Oe5+L+zznDZL/QZ8urY9CNkY52fHeQBmGzk2B2c+hNHHY7bSwEb0Fyy0d2cyS9cGVXUsl//C5ZcC6IZdr5uiLz0Eqz/1Zx3itj1o6URhg71vAsXWBy+3y08U4a7EpIkgj3P4lamFw1/JC/dYZBcIEfyx8GjFAAXudw/iai6xK4761I/x7ntczAOlQwMPulQclsql9L9B8cHwOQHwjMWzQKsn5onHfxQd3ZD8qh1GutSKVS2XtSstwhTdRI9RV4YHB49jazjoPNnXTaFUT0wrpyyM2KS3kGodaXJU64Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VgHaMSHjzT/0zjQ0pI4WCxHhzXq+lVzVgnR2S6Fmzo=;
 b=nYeCi7WZvQ2MKWi1vvjT4Fd2yht71H4ShpUpMZRGoGdxyWHx+ytEKFM3GF4Rs9uBJU1Vda9nL1d1nSGWWkg9vjw+EejAH8F00jJVHKfMvfwmXE/z3IKunO6Q/2X6/fg0n8a65x5E+IiOoYEBr3QS5PWUffKanvFI+h/n0uFkLUQvnYK8VcUBFEYHpEQmo80qxDpBSeqZ4MqsfKmMYg3OwtEcx0WHvrWqbj5dEjvtyWqEcGw6UIeOVnlscar+7Z+JzMNM0dr0bKz/tbfKBnxsQ2WcPQGEUCsO5xj2OE/4wpAUW+OJqtZD3XLJnR7b4eDyfNQ/WVtIMsGxiC/UuCX8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: us.ibm.com; dkim=none (message not signed)
 header.d=none;us.ibm.com; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com (2603:10a6:208:128::18)
 by AM0PR04MB4036.eurprd04.prod.outlook.com (2603:10a6:208:64::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Mon, 11 Oct
 2021 18:23:11 +0000
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::80b4:c12e:2fb5:8b30]) by AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::80b4:c12e:2fb5:8b30%3]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 18:23:11 +0000
Subject: Re: [PATCH V7 1/3] genirq: add device_has_managed_msi_irq
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>
References: <20210818144428.896216-1-ming.lei@redhat.com>
 <20210818144428.896216-2-ming.lei@redhat.com>
From:   Varad Gautam <varad.gautam@suse.com>
Message-ID: <6da6924e-88ab-b1e4-e3bf-6f8d3967b690@suse.com>
Date:   Mon, 11 Oct 2021 20:23:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210818144428.896216-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0275.eurprd06.prod.outlook.com
 (2603:10a6:20b:45a::24) To AM0PR04MB5650.eurprd04.prod.outlook.com
 (2603:10a6:208:128::18)
MIME-Version: 1.0
Received: from [192.168.77.236] (95.90.91.212) by AS9PR06CA0275.eurprd06.prod.outlook.com (2603:10a6:20b:45a::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.21 via Frontend Transport; Mon, 11 Oct 2021 18:23:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd289de8-5840-4a98-38f5-08d98ce42e8e
X-MS-TrafficTypeDiagnostic: AM0PR04MB4036:
X-Microsoft-Antispam-PRVS: <AM0PR04MB40360A4E14E044E4A73C0E5DE0B59@AM0PR04MB4036.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0FgR2uQv5CPpubpXnUY88gHwLjBhLyxsAEDY1HzaznTVubyA38KmJXh3i+sK9/Lr8QaCB3R1HkmqRuQbcgdH/rAGYQByebk3YiWnEAMDn6I4VTbVhJLDYsqoljE6B9GrvTD7AErzQ1WR136tnMJzHH2oDCHZrNSw07bzPW3ELOBlgf+MjZSezXH86mwuwrXGPk20Q3aN0SkLMNeAV9HNazuvcMBpwp3UWZbhJ7LurBHhaowHloltXFasAVL4lXOYJeRY+HDjWlV+EL22DNjrKOvflH679YwTyf2y7i/Rta3eXMF4IXLC5gnmEbXxPnc58IJeH7qR/OQD2FXBDz6P9Io4zuptzk0b/kP9R/3SVS3iXZsIGnpSsWG+ct1SQgiOn6CrhGJdY2jpy8nowi4k8KPRki0jgHFZha5uu2aR5ME1lrYwYj6M9WbFcQmw8zI22f4q2GR476GLJLwyDbB2VwLXF4xFBgySep74OdbFR+Lwyj+sMjyarMnc+g51ClIlFJCTh6F6IJeUEyDhST95/HmdCIvdXl4Yfnlzk7siW8sJOzEVxp9tm9MU3/wKlhQPU+6JrKnt/1UZ/G0yBbNBinoG2yd7yLMPfcNjMonJMcDqVmt9uXhgdRpG1TLcru29wSIr6f2VIXQ6apS4JW+aWkdy2YgINbl0g1foWTkYaLufkf83vHcoHHmhFJ6hs+ksgYeNPg9asw94s94yqRNXWWmBRxokgcaJIHDNoex5wdk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5650.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(16576012)(53546011)(2906002)(31686004)(2616005)(316002)(8676002)(4326008)(956004)(26005)(38100700002)(8936002)(110136005)(6486002)(54906003)(5660300002)(31696002)(36756003)(83380400001)(44832011)(186003)(66476007)(66556008)(66946007)(86362001)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R05FaEJoeUR2cmpjV3hkZll2RU1GZmVuNWJvSVRGanhTeG9oOUpQUGpOc1BN?=
 =?utf-8?B?d2xHWFlDby9tbnJKcjl6aWtnS0o0cjBSZEdQdEdlYkp6ZGRzSVl5Q29BTEFo?=
 =?utf-8?B?MnJYbEJVMitzblVoeGk5a3JNaER4azR4dzBTT2gvZWF1NFJLaVBKb2dTUU1N?=
 =?utf-8?B?S2Q0VWhvNUxHRDgwT2ZOUlRsMk50OWc4TS9FTEkwNUdnTFdiNXFhOHlZL1dK?=
 =?utf-8?B?U3JXZ1lEWVNWZHBHMXZNMzRDQWRsem1JNzJUUFdoQmM5MjRaZkJ5bzhzUTlC?=
 =?utf-8?B?Yy9scGE5d00rMCtoeHE5alkwT015T3FCMWtETkxIQ3dUL1F1QndmNzZndThs?=
 =?utf-8?B?YlMvTjhJaENCUC8yT2VRVkwwMFhFREZIbHk1WGdybG9JOFlPQ0hnSnhyVEI3?=
 =?utf-8?B?OUZZV3dKNSt2Yk5kVFhpcTc0eTNkaWRuYytGMDZHSEVvT0ZxSVV2Y2wva0hB?=
 =?utf-8?B?S1VkTlJVcnRXa0NRMkJFdVdSUDJFRHZOZ3RzK0REWElzU3B1NjQ3WmNHNEVG?=
 =?utf-8?B?U0Y3WnFSbXVFblJnNHdIU0lPR3NPZXlpUlY2ZWpSa1hjaTRmR1kyZWtzMWsw?=
 =?utf-8?B?UjhyTlNpenFjVlI2ZENpRUJWWisvanV2RzhBeCsyNHNDS3Z3anowZWpJMVFM?=
 =?utf-8?B?VFUzYWEvdjVwa2xqcFZDYTNONFd2TVk3dkJVN1p6RFFrblJwclhhS0JWTWRt?=
 =?utf-8?B?d0xSVVRIL3ArQ2N5WDQ2TnlROSs3a3ZwdDdBM2xwbGhYTlRkOHhVZVIrbFRB?=
 =?utf-8?B?VGpzSkdpL3BEN2wzTnJvVm9HUngxM0JaQ0x6TFZPU2pLcWdIalJlaGNqWTFu?=
 =?utf-8?B?WEJ0UFliS1IvdG5qS1hOdXEyRmtHeUZUQnJKK0hHeUg4VFd5SlJOSjJOeUtz?=
 =?utf-8?B?amkwcjFZZ3VnRTM0ejJraENFNVcxSGxVYTB1elFoMW9hR2N5M2FvcUtRN2Rq?=
 =?utf-8?B?NjBLWk1jbTcxOFNzYnA2UENZb3dxWmVVMWU3WHBjaDBKRmhMZzhuNXBEUjNt?=
 =?utf-8?B?b3J0MmlGT1hvSGFGOXJNZ2RGSGhHMzdnRmNRS3Q4UUt1akE0UHE2bmFqeCts?=
 =?utf-8?B?WlQ0WVNNRWQ2bWRET0ZiSGhrd2tWNjNEVWVYanNmcFgwd0I0cUtoSWNSTmJX?=
 =?utf-8?B?TWcvRUZIeFBCK0tPLzJXL0JmaFZyY3pRY2E4empQZkJ5dm9MZmFtOWhwWEVM?=
 =?utf-8?B?LytWV1JTVVpTSmdadFNHNEdvSGlaN0pDOUowd3N0NVo3WTVmeVhVYlhGT1py?=
 =?utf-8?B?TEZRNjJzT0NmT1c4R2dYUGw1RjkxdE9DTmtPZXZBbjhLZzhmNWpjQkRkdHhO?=
 =?utf-8?B?LzM5TmQ1Z2tLYVNFVGZYa3JBV3ZYZm9hQ243ZE5sSkhNOFZhbjFwOVdmNDd3?=
 =?utf-8?B?UDZOYk50ZEloZExqb0tqZ1ErOGhPcktSVnNjbzI4Q21zQWRYbGtZVFJRTzAz?=
 =?utf-8?B?K0x4M0pFVUFZVEtSTG4vQ2lpaEdTSDBKcDRjV2RKRlpZYXJYU01UdVhSMk1h?=
 =?utf-8?B?d0owcXlUT1dYVzVIaDVOOGpMdW5uZkI3M2ZsTXAvZVh4N0lMQ3dISDU4SktF?=
 =?utf-8?B?eU1vQ3hPOElBenBFQ21rc3RXdWZQQlFYWDUyWVV3cmRJTlRZZUlReGR2RjJs?=
 =?utf-8?B?ZDY1WEZ4djFMSVdweTJCd2JxNmVaazdXNmFvcGlhT3hoVU9uMXZkWkp6UVZG?=
 =?utf-8?B?NlFMQnhQZWJSN0xZdU45aWRvMGJSc1l5WTcycWlIVU45OVdaWGc1WHVTczlj?=
 =?utf-8?Q?2zXOzbi5qKSShaeh0Fbh8aO+YS7HfJg/P3uqAEz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd289de8-5840-4a98-38f5-08d98ce42e8e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5650.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 18:23:11.5248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 432e5pMoyIBh/OjehyCS4/9nMko5NVLEclBh7DPs5JnO6cR2/bpnl4bnuECsjsww5KqUMlyD1uA4TYNMyI4/og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4036
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On 8/18/21 4:44 PM, Ming Lei wrote:
> irq vector allocation with managed affinity may be used by driver, and
> blk-mq needs this info for draining queue because genirq core will shutdown
> managed irq when all CPUs in the affinity mask are offline.
> 
> The info of using managed irq is often produced by drivers, and it is
> consumed by blk-mq, so different subsystems are involved in this info flow.
> 
> Address this issue by adding one helper of device_has_managed_msi_irq()
> which is suggested by John Garry.
> 
> Tested-by: Wen Xiong <wenxiong@us.ibm.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Suggested-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  include/linux/msi.h |  5 +++++
>  kernel/irq/msi.c    | 18 ++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index a20dc66b9946..b4511c606072 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -59,10 +59,15 @@ struct platform_msi_priv_data;
>  void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
>  #ifdef CONFIG_GENERIC_MSI_IRQ
>  void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
> +bool device_has_managed_msi_irq(struct device *dev);

This led me to the following build warning:

In file included from ../drivers/iommu/irq_remapping.c:6:0:
../include/linux/msi.h:23:40: warning: 'struct device' declared inside parameter list will not be visible outside of this definition or declaration

A forward declaration for struct device before the #ifdef
would fix this.

Regards,
Varad

>  #else
>  static inline void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
>  {
>  }
> +static inline bool device_has_managed_msi_irq(struct device *dev)
> +{
> +	return false;
> +}
>  #endif
>  
>  typedef void (*irq_write_msi_msg_t)(struct msi_desc *desc,
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 00f89d5bd6f6..167bc1d8bf4a 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -71,6 +71,24 @@ void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
>  }
>  EXPORT_SYMBOL_GPL(get_cached_msi_msg);
>  
> +/**
> + * device_has_managed_msi_irq - Query if device has managed irq entry
> + * @dev:	Pointer to the device for which we want to query
> + *
> + * Return true if there is managed irq vector allocated on this device
> + */
> +bool device_has_managed_msi_irq(struct device *dev)
> +{
> +	struct msi_desc *desc;
> +
> +	for_each_msi_entry(desc, dev) {
> +		if (desc->affinity && desc->affinity->is_managed)
> +			return true;
> +	}
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(device_has_managed_msi_irq);
> +
>  #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
>  static inline void irq_chip_write_msi_msg(struct irq_data *data,
>  					  struct msi_msg *msg)
> 

